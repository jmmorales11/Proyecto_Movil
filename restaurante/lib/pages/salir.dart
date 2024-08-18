import 'package:flutter/material.dart';

class Salir extends StatefulWidget {
  const Salir({super.key});

  @override
  State<Salir> createState() => _SalirState();
}

class _SalirState extends State<Salir> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Esta es la página de Salir'),
    );
  }
}
