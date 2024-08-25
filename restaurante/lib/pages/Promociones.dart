import 'package:flutter/material.dart';

class Promociones extends StatefulWidget {
  const Promociones({super.key});

  @override
  State<Promociones> createState() => _SalirState();
}

class _SalirState extends State<Promociones> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Esta es la página de Promociones '),
    );
  }
}
