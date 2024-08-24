import 'package:flutter/material.dart';
import 'package:restaurante/pages/comida.dart';
import 'package:restaurante/services/map_box_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocalListPage extends StatefulWidget {
  final String tipoComida;

  LocalListPage({required this.tipoComida});

  @override
  _LocalListPageState createState() => _LocalListPageState();
}

class _LocalListPageState extends State<LocalListPage> {
  List<Map<String, dynamic>> _locales = [];
  final MapboxService _mapboxService = MapboxService();

  @override
  void initState() {
    super.initState();
    fetchLocations(widget.tipoComida);
  }

  Future<void> fetchLocations(String categoria) async {
    final url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$categoria.json?access_token=sk.eyJ1IjoiZXByYW1pcmV6MiIsImEiOiJjbTA1dm9uemYwbXlqMmpwd2NpenY1eWt2In0.ZHQ14IrAeojcL6PjrBfFnw&limit=10&proximity=-78.467838,-0.180653';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        _locales = (data['features'] as List).map((feature) {
          return {
            'place_name': feature['place_name'],
            'coordinates': feature['geometry']['coordinates']
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load locations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Locales de ${widget.tipoComida}")),
      body: ListView.separated(
        itemCount: _locales.length,
        separatorBuilder: (context, index) => Divider(height: 1.0, color: Colors.grey[300]),
        itemBuilder: (context, index) {
          final local = _locales[index];
          final placeName = local['place_name'];
          
          // Split the place name into parts using commas
          final parts = placeName.split(',');
          
          // Ensure there are enough parts
          final boldPart = parts.isNotEmpty ? parts[0] : '';
          final restPart = parts.length > 1 ? parts.sublist(1).join(',') : '';

          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: boldPart,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black
                    ),
                  ),
                  TextSpan(
                    text: restPart,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async {
              final placeDetails = await _mapboxService.getPlaceDetails(placeName);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Comida(
                    tipoComida: widget.tipoComida,
                    local: placeDetails, // Pasar local con detalles
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
