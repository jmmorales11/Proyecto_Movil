import 'package:flutter/material.dart';
import 'package:restaurante/Fondos/GradientBackground.dart';
// Importa el nuevo widget

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usa el widget GradientBackground para aplicar el fondo
      body: GradientBackground(
        child: Column(
          children: [
            // Espacio para separar el campo de búsqueda del AppBar
            SizedBox(height: 75.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 300.0, // Tamaño más corto para la barra de búsqueda
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                    hintText: 'Buscar',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            // Espacio debajo del campo de búsqueda
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2, // Número de columnas
                  crossAxisSpacing: 16.0, // Espacio horizontal entre cuadros
                  mainAxisSpacing: 16.0, // Espacio vertical entre cuadros
                  children: [
                    _buildGridItem('Comidaa', 'Subtítulo 1'),
                    _buildGridItem('Título 2', 'Subtítulo 2'),
                    _buildGridItem('Título 3', 'Subtítulo 3'),
                    _buildGridItem('Título 4', 'Subtítulo 4')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir cada ítem del GridView
  Widget _buildGridItem(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Color de fondo de las cajas
        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Cambia la posición de la sombra
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.star, // Cambia el ícono según tus necesidades
              size: 40.0,
              color: Colors.blue,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
