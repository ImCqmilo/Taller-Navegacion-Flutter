import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String value;

  const DetailScreen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle")),
      body: Center(child: Text("Valor recibido: $value")),
    );
  }
}