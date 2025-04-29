import 'package:flutter/material.dart';
import 'dart:isolate';

class HeavyTaskScreen extends StatelessWidget {
  const HeavyTaskScreen({super.key});

  Future<int> _performHeavyTask() async {
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_heavyComputation, receivePort.sendPort);
    return await receivePort.first;
  }

  static void _heavyComputation(SendPort sendPort) {
    int sum = 0;
    for (int i = 1; i <= 2000000; i++) {
      sum += i;
    }
    sendPort.send(sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarea Pesada')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            int result = await _performHeavyTask();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Resultado: $result')),
              );
            }
          },
          child: const Text('Ejecutar Tarea Pesada'),
        ),
      ),
    );
  }
}
