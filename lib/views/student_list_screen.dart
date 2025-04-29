import 'package:flutter/material.dart';

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
