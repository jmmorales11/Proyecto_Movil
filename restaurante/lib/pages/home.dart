import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necesario para SystemNavigator.pop()
import 'package:restaurante/Fondos/GradientBackground.dart';
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
    Salir(),
  ];

  static const List<String> _titles = [
    'Página de Inicio',
    'Página de Salir',
  ];

  static const List<IconData> _icons = [
    Icons.home,
    Icons.exit_to_app,
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
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
                SystemNavigator.pop(); // Cierra la aplicación
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
                Text('Usuario'),
                SizedBox(width: 8),
                Icon(Icons.account_circle), // Icono de usuario a la derecha
                SizedBox(width: 16), // Espacio a la derecha del icono
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GradientBackground(
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
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
