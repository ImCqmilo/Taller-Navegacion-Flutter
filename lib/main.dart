import 'package:flutter/material.dart';
import 'package:hola_mundo/form_view.dart';
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/detail/:value', builder: (context, state) {
      final value = state.pathParameters['value']!;
      return DetailScreen(value: value);
    }),
    GoRoute(path: '/students', builder: (context, state) => const StudentListScreen()),
    GoRoute(path: '/timer', builder: (context, state) => const TimerScreen()),
    GoRoute(path: '/isolate', builder: (context, state) => const HeavyTaskScreen()),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')), 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () => context.push('/detail/Flutter'), child: const Text('Ir a Detalle')),
          ElevatedButton(onPressed: () => context.push('/students'), child: const Text('Lista de Estudiantes')),
          ElevatedButton(onPressed: () => context.push('/timer'), child: const Text('Temporizador')),
          ElevatedButton(onPressed: () => context.push('/isolate'), child: const Text('Tarea Pesada')),
        ],
      ),
    );
  }
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Future<List<String>> _students;

  Future<List<String>> _fetchStudents() async {
    return Future.delayed(const Duration(seconds: 3), () => ['Alice', 'Bob', 'Charlie', 'David']);
  }

  @override
  void initState() {
    super.initState();
    _students = _fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Estudiantes')),
      body: FutureBuilder<List<String>>(
        future: _students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            return ListView(
              children: snapshot.data!.map((name) => ListTile(title: Text(name))).toList(),
            );
          }
        },
      ),
    );
  }
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _counter = 0;
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _counter++;
        });
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _pauseTimer();
    setState(() {
      _counter = 0;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temporizador')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tiempo: $_counter s', style: Theme.of(context).textTheme.headlineMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _startTimer, child: const Text('Iniciar')),
              ElevatedButton(onPressed: _pauseTimer, child: const Text('Pausar')),
              ElevatedButton(onPressed: _resetTimer, child: const Text('Reiniciar')),
            ],
          ),
        ],
      ),
    );
  }
}

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
