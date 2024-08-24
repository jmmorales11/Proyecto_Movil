import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comida extends StatefulWidget {
  final String tipoComida;
  final Map<String, dynamic> local;

  Comida({required this.tipoComida, required this.local});

  @override
  _ComidaState createState() => _ComidaState();
}

class _ComidaState extends State<Comida> {
  String _mapStyle = "streets-v11"; // Estilo de mapa predeterminado
  List<LatLng> _routePoints = []; // Lista de puntos para la ruta

  final Map<String, String> _mapStyles = {
    'Streets': 'streets-v11',
    'Light': 'light-v10',
    'Dark': 'dark-v10',
    'Outdoors': 'outdoors-v11',
  };

  @override
  void initState() {
    super.initState();
    _fetchRoute(); // Obtener la ruta cuando se inicializa el estado
  }

  Future<void> _fetchRoute() async {
    final coordinates = widget.local['coordinates'];
    final localLatLng = LatLng(coordinates[1], coordinates[0]);
    final currentLocation = LatLng(-0.2332, -78.5250); // Ubicación actual del usuario

    final response = await http.get(
      Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/driving/${currentLocation.longitude},${currentLocation.latitude};${localLatLng.longitude},${localLatLng.latitude}?geometries=geojson&access_token=sk.eyJ1IjoiZXByYW1pcmV6MiIsImEiOiJjbTA1dm9uemYwbXlqMmpwd2NpenY1eWt2In0.ZHQ14IrAeojcL6PjrBfFnw',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final route = data['routes'][0]['geometry']['coordinates'] as List;
      setState(() {
        _routePoints = route.map((coord) => LatLng(coord[1], coord[0])).toList();
      });
    } else {
      throw Exception('Failed to load route');
    }
  }

  @override
  Widget build(BuildContext context) {
    final coordinates = widget.local['coordinates'];
    final LatLng localLatLng = LatLng(coordinates[1], coordinates[0]);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.local['name']),
        actions: [
          PopupMenuButton<String>(
            onSelected: (style) {
              setState(() {
                _mapStyle = _mapStyles[style]!;
              });
            },
            itemBuilder: (BuildContext context) {
              return _mapStyles.keys.map((String style) {
                return PopupMenuItem<String>(
                  value: style,
                  child: Text(style),
                );
              }).toList();
            },
            icon: Icon(Icons.map),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: localLatLng,
                initialZoom: 15.0,
                minZoom: 10.0,
                maxZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://api.mapbox.com/styles/v1/mapbox/$_mapStyle/tiles/{z}/{x}/{y}?access_token=sk.eyJ1IjoiZXByYW1pcmV6MiIsImEiOiJjbTA1dm9uemYwbXlqMmpwd2NpenY1eWt2In0.ZHQ14IrAeojcL6PjrBfFnw",
                  additionalOptions: {
                    'accessToken': 'sk.eyJ1IjoiZXByYW1pcmV6MiIsImEiOiJjbTA1dm9uemYwbXlqMmpwd2NpenY1eWt2In0.ZHQ14IrAeojcL6PjrBfFnw',
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: localLatLng,
                      width: 80.0,
                      height: 80.0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(Icons.location_on, color: Colors.red, size: 40.0),
                      ),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dirección: ${widget.local['address']}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
