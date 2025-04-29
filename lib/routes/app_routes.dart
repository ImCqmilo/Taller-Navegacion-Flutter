import 'package:go_router/go_router.dart';
import 'package:hola_mundo/api_screen.dart';
import 'package:hola_mundo/views/Auth/login_page.dart';
import 'package:hola_mundo/views/Auth/register_page.dart';
import 'package:hola_mundo/views/HeavyTaskScreen.dart';
import 'package:hola_mundo/views/detail_screen.dart';
import 'package:hola_mundo/views/home_page.dart';
import 'package:hola_mundo/views/student_list_screen.dart';
import 'package:hola_mundo/views/timer_screen.dart';



final GoRouter appRouter  = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/detail/:title',
      name: 'detail',
      builder: (context, state) {
        final value = state.pathParameters['title']!; 
        return DetailScreen(value: value);
      },
    ),
    GoRoute(
      path: '/students',
      name: 'students',
      builder: (context, state) => const StudentListScreen(),
    ),
    GoRoute(
      path: '/timer',
      name: 'timer',
      builder: (context, state) => const TimerScreen(),
    ),
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const HeavyTaskScreen(),
    ),
    GoRoute(
      path: '/api',
      name: 'api',
      builder: (context, state) => const ApiScreen(),
    ),
  ],
);
