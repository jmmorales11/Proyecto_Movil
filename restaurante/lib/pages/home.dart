import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necesario para SystemNavigator.pop()
import 'package:restaurante/Fondos/GradientBackground.dart';
import 'package:restaurante/pages/Promociones.dart';
import 'package:restaurante/pages/inicio.dart';
import 'package:restaurante/pages/salir.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Inicio(),
    Promociones(), // Añade la página de promociones
    Salir(),
  ];

  static const List<String> _titles = [
    'Inicio',
    'Promociones', // Cambia el título para promociones
//    'Página de Salir',
  ];

  static const List<IconData> _icons = [
    Icons.home,
    Icons.local_offer, // Icono para promociones
    //  Icons.exit_to_app,
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showExitConfirmationDialog(); // Mostrar el diálogo al hacer clic en "Salir"
    } else {
      setState(() {
        _selectedIndex = index;
      });
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
                  MaterialPageRoute(builder: (context) => Salir()),
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
            child: _pages[_selectedIndex],
          ),
          // Colocamos el AppBar en la parte superior del Stack
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
                      Icon(_icons[_selectedIndex]),
                      SizedBox(width: 8),
                      Text(_titles[_selectedIndex]),
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
                              color: Colors.white, // Color de fondo blanco
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
                  alignment: Alignment.bottomLeft, // Alinear a la izquierda
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer), // Cambia el ícono para promociones
            label: 'Promociones',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(169, 214, 120, 103),
        onTap: _onItemTapped,
      ),
    );
  }
}
