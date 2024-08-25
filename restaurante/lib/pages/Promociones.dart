import 'package:flutter/material.dart';
import 'package:restaurante/Fondos/GradientBackground.dart';
import 'package:restaurante/pages/comida.dart';

class Promociones extends StatefulWidget {
  const Promociones({super.key});

  @override
  State<Promociones> createState() => _PromocionesState();
}

class _PromocionesState extends State<Promociones> {
  final List<Map<String, dynamic>> promociones = [
    {
      "nombre": "Hamburguesa del Sese",
      "descuento": "20% de descuento",
      "ubicacion": "Quito, Ecuador",
      "imagen": "assets/images/hamburgesa.png",
      "local": {
        "name": "Hamburguesa del Sese",
        "coordinates": [-78.4905108, -0.2071631],  // Coordenadas de ejemplo para el local
        "address": "José Tamayo, Quito",
      }
    },
    {
      "nombre": "Papa Pizza",
      "descuento": "15% de descuento",
      "ubicacion": "Quito, Ecuador",
      "imagen": "assets/images/pizza.png",
      "local": {
        "name": "Papa Pizza",
        "coordinates": [-78.4678, -0.1807],  // Coordenadas de ejemplo para el local
        "address": "Rio Ambi, Quito",
      }
    },
    {
      "nombre": "Hot Dogs de la Gonzales Suarez",
      "descuento": "10% de descuento",
      "ubicacion": "Quito, Ecuador",
      "imagen": "assets/images/hotDogGonzales.png",
      "local": {
        "name": "Hot Dogs de la Gonzales Suarez",
        "coordinates": [-78.5211736, -0.24973765],  // Coordenadas corregidas
        "address": "Avenida Pedro Vicente Maldonado, Quito",
      }
    },
    //nuevas promos
    // {
    //   "nombre": "Encebollados del Triángulo",
    //   "descuento": "8% de descuento",
    //   "ubicacion": "Quito, Ecuador",
    //   "imagen": "assets/images/encebollado.png",
    //   "local": {
    //     "name": "Encebollados del Triángulo",
    //     "coordinates": [-78.5307988, -0.2616854],  // Coordenadas corregidas
    //     "address": "Teniente Hugo Ortiz, Quito",
    //   }
    // },
    // {
    //   "nombre": "Papitas a lo Bestia",
    //   "descuento": "15% de descuento en la segunda salchipapa",
    //   "ubicacion": "Quito, Ecuador",
    //   "imagen": "assets/images/papitasAloBestia.png",
    //   "local": {
    //     "name": "Papitas a lo Bestia",
    //     "coordinates": [-78.5411601, -0.2739715],  // Coordenadas corregidas
    //     "address": "Avenida Solanda, Quito",
    //   }
    // },
    // {
    //   "nombre": "Los Hornados de San Carlos",
    //   "descuento": "20% de descuento",
    //   "ubicacion": "Quito, Ecuador",
    //   "imagen": "assets/images/hornadosSanCarlos.png",
    //   "local": {
    //     "name": "Los Hornados de San Carlos",
    //     "coordinates": [-78.5008476, -0.1290801],  // Coordenadas corregidas
    //     "address": "Cristóbal Vaca de Castro, Quito",
    //   }
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            margin: const EdgeInsets.only(top: 80.0),
            child: ListView.builder(
              itemCount: promociones.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.asset(
                            promociones[index]['imagen']!,
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            promociones[index]['nombre']!,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 207, 87, 78),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                promociones[index]['descuento']!,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                promociones[index]['ubicacion']!,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.local_offer, color: Colors.red),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Comida(
                                      tipoComida: promociones[index]['nombre']!,
                                      local: promociones[index]['local'],
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.map, color: Color.fromARGB(255, 252, 93, 82)),
                              label: Text('Ver en el mapa'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 216, 128, 122),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
