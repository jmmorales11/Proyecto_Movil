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
            SizedBox(height: 130.0),
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
                    _navigateToComida(
                        context, value); // Busca lo que se ingrese
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lo mejor de lo mejor',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(
                                255, 207, 87, 78), // Color rojo del fondo
                          ),
                        ),
                        Text(
                          'Encuentra los mejores lugares',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Image.asset(
                    'assets/images/logo.png', // Ruta de la imagen en assets
                    height: 120.0,
                    width: 120.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    _buildGridItem(
                        'Hamburguesas',
                        'Restaurantes de Hamburguesas',
                        'assets/images/hamburgesa.png'),
                    _buildGridItem('Pizza', 'Restaurantes de Pizza',
                        'assets/images/pizza.png'),
                    _buildGridItem('Sushi', 'Restaurantes de Sushi',
                        'assets/images/sushi.png'),
                    _buildGridItem('Tacos', 'Restaurantes de Tacos',
                        'assets/images/tacos.png'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, String subtitle, String imagePath) {
    return GestureDetector(
      onTap: () => _navigateToComida(
          context, title), // Navegar a la búsqueda al hacer clic
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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            Positioned(
              bottom: -10.0, // Ajusta según lo necesites
              right: -5.0, // Ajusta según lo necesites
              child: Image.asset(
                imagePath,
                height: 120.0, // Ajusta según lo necesites
                width: 120.0, // Ajusta según lo necesites
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToComida(BuildContext context, String comida) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocalListPage(
            tipoComida: comida), // Pasa el tipo de comida seleccionado
      ),
    );
  }
}
