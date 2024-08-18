import 'package:flutter/material.dart';

class Comida extends StatefulWidget {
  const Comida({super.key});

  @override
  State<Comida> createState() => _ComidaState();
}

class _ComidaState extends State<Comida> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Esta es la página de Comida'),
    );
  }
}
