import 'package:flutter/material.dart';
import 'package:restaurante/pages/comida.dart';
import 'package:restaurante/services/map_box_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurante/Fondos/GradientBackground.dart';

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
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$categoria.json?access_token=sk.eyJ1IjoiZXByYW1pcmV6MiIsImEiOiJjbTA1dm9uemYwbXlqMmpwd2NpenY1eWt2In0.ZHQ14IrAeojcL6PjrBfFnw&limit=10&proximity=-78.467838,-0.180653';

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

  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('¿Seguro que quieres salir?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salir'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          LocalListPage(tipoComida: widget.tipoComida)),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extender el cuerpo detrás del AppBar
      body: Stack(
        children: [
          GradientBackground(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 90.0), // Espacio para el AppBar
              child: ListView.separated(
                itemCount: _locales.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: 8.0), // Espacio entre los items
                itemBuilder: (context, index) {
                  final local = _locales[index];
                  final placeName = local['place_name'];

                  // Split the place name into parts using commas
                  final parts = placeName.split(',');

                  // Ensure there are enough parts
                  final boldPart = parts.isNotEmpty ? parts[0] : '';
                  final restPart =
                      parts.length > 1 ? parts.sublist(1).join(',') : '';

                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 16.0), // Margen horizontal
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          99, 255, 255, 255), // Fondo blanco
                      borderRadius:
                          BorderRadius.circular(12.0), // Bordes redondeados
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 2), // Sombra con desplazamiento
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: boldPart,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: restPart,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        final placeDetails =
                            await _mapboxService.getPlaceDetails(placeName);
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
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors
                      .transparent, // Hacer el fondo del AppBar transparente
                  elevation: 0, // Eliminar la sombra del AppBar
                  title: Row(
                    children: [
                      Icon(
                          Icons.local_offer), // Icono para la página de locales
                      SizedBox(width: 8),
                      Text(' ${widget.tipoComida}'),
                    ],
                  ),
                  actions: [
                    PopupMenuButton<int>(
                      onSelected: (item) {
                        if (item == 0) {
                          _showExitConfirmationDialog(); // Mostrar el diálogo al seleccionar "Salir"
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.exit_to_app),
                              SizedBox(width: 8),
                              Text('Salir'),
                            ],
                          ),
                        ),
                      ],
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(
                                  255, 255, 255, 255), // Color de fondo blanco
                              borderRadius: BorderRadius.circular(
                                  16.0), // Bordes redondeados
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 2), // Cambiar posición de la sombra
                                ),
                              ],
                            ),
                            child: Text(
                              'Usuario',
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Texto en negrita
                                color: Colors.red, // Color principal del texto
                                shadows: [
                                  Shadow(
                                    color: Colors
                                        .yellow, // Color del detalle en amarillo
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons
                              .account_circle), // Icono de usuario a la derecha
                          SizedBox(width: 16), // Espacio a la derecha del icono
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 16.0, bottom: 8.0), // Margen izquierdo y abajo
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromARGB(136, 138, 127, 127), // Gris sólido
                          Color.fromARGB(0, 138, 127, 127) // Gris transparente
                        ],
                      ),
                    ),
                    height: 20.0, // Altura del recuadro gris
                    width: 200, // Ancho del recuadro gris
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
