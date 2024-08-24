import 'package:flutter/material.dart';
import 'package:restaurante/Fondos/GradientBackground.dart';
import 'package:restaurante/pages/local_list_page.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          children: [
            SizedBox(height: 75.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 300.0,
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
                  onSubmitted: (value) {
                    _navigateToComida(context, value);  // Busca lo que se ingrese
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    _buildGridItem('Hamburguesas', 'Restaurantes de Hamburguesas'),
                    _buildGridItem('Pizza', 'Restaurantes de Pizza'),
                    _buildGridItem('Sushi', 'Restaurantes de Sushi'),
                    _buildGridItem('Tacos', 'Restaurantes de Tacos')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, String subtitle) {
    return GestureDetector(
      onTap: () => _navigateToComida(context, title),  // Navegar a la búsqueda al hacer clic
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.fastfood,  // Puedes cambiarlo según el tipo de comida
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
      ),
    );
  }

  void _navigateToComida(BuildContext context, String comida) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocalListPage(tipoComida: comida),  // Pasa el tipo de comida seleccionado
      ),
    );
  }
}
