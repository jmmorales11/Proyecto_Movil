import 'package:flutter/material.dart';
import 'package:restaurante/Fondos/GradientBackground.dart';
import 'package:restaurante/pages/comida.dart';
import 'package:restaurante/pages/inicio.dart';
import 'package:restaurante/pages/salir.dart';
// Importa el widget GradientBackground

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Inicio(),
    Comida(),
    Salir(),
  ];

  static const List<String> _titles = [
    'Página de Inicio',
    'Página de Comida',
    'Página de Salir',
  ];

  static const List<IconData> _icons = [
    Icons.home,
    Icons.fastfood,
    Icons.exit_to_app,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Icon(_icons[_selectedIndex]),
            SizedBox(width: 8),
            Text(_titles[_selectedIndex]),
          ],
        ),
        actions: [
          Row(
            children: [
              Text('Usuario'),
              SizedBox(width: 8),
              Icon(Icons.account_circle), // Icono de usuario a la derecha
              SizedBox(width: 16), // Espacio a la derecha del icono
            ],
          ),
        ],
      ),
      body: GradientBackground(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Comida',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Salir',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
