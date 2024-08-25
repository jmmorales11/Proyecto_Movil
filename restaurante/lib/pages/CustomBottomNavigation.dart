import 'package:flutter/material.dart';
import 'package:restaurante/pages/Promociones.dart';
import 'package:restaurante/pages/inicio.dart';
import 'package:restaurante/pages/salir.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigation({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  static const List<Widget> _pages = <Widget>[
    Inicio(),
    Promociones(),
    Salir(),
  ];

  static const List<String> _titles = [
    'Inicio',
    'Promociones',
    // 'Salir', // Se puede comentar si no se usa en la AppBar
  ];

  static const List<IconData> _icons = [
    Icons.home,
    Icons.local_offer,
    Icons.exit_to_app,
  ];

  void _showExitConfirmationDialog(BuildContext context) {
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
      body: _pages[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Promociones',
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Color.fromARGB(169, 214, 120, 103),
        onTap: (index) {
          if (index == 2) {
            _showExitConfirmationDialog(context);
          } else {
            widget.onItemTapped(index);
          }
        },
      ),
    );
  }
}
