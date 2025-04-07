import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  // Función que consume la API y retorna una lista de usuarios
  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']; // Devuelve la lista de usuarios
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de API'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            return ListView(
              children: (snapshot.data!).map((user) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['avatar']),
                ),
                title: Text('${user['first_name']} ${user['last_name']}'),
                subtitle: Text(user['email']),
              )).toList(),
            );
          }
        },
      ),
    );
  }
}
