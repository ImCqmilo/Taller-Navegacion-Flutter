import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.push('/login'),
            child: const Text('Ir a Login'),
          ),
          ElevatedButton(
            onPressed: () => context.push('/detail/Flutter'),
            child: const Text('Ir a Detalle'),
          ),
          ElevatedButton(
            onPressed: () => context.push('/students'),
            child: const Text('Lista de Estudiantes'),
          ),
          ElevatedButton(
            onPressed: () => context.push('/timer'),
            child: const Text('Temporizador'),
          ),
          ElevatedButton(
            onPressed: () => context.push('/isolate'),
            child: const Text('Tarea Pesada'),
          ),
          ElevatedButton(
            onPressed: () => context.push('/api'),
            child: const Text('Consumo de API'),
          ),
        ],
      ),
    );
  }
}
