import 'package:flutter/material.dart';
import 'package:hola_mundo/form_view.dart';
import 'package:go_router/go_router.dart';

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
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detail/:value',
      builder: (context, state) {
        final value = state.pathParameters['value']!;
        return DetailScreen(value: value);
      },
    ),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')), 
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/detail/Flutter');
          },
          child: const Text('Detalle'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String value;
  const DetailScreen({super.key, required this.value});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print('initState ejecutado');
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies ejecutado');
  }

  @override
  Widget build(BuildContext context) {
    print('build ejecutado');
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle: ${widget.value}'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Lista'),
            Tab(text: 'Grid'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.label),
                title: Text('Elemento numero $index'),
              );
            },
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
                child: Center(child: Text('Item numero $index')),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print('setState ejecutado');
  }

  @override
  void dispose() {
    _tabController.dispose();
    print('dispose ejecutado');
    super.dispose();
  }
}
