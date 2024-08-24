import 'package:flutter/material.dart';
import 'package:restaurante/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Color.fromARGB(255, 207, 87, 78)),
      title: 'Material App',
      home: HomeScreen(),
    );
  }
}