import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'login_page.dart';
import 'menu_page.dart';
import 'quienes_somos_page.dart';
import 'contacto_page.dart';

void main() {
  // Agregar manejo global de errores
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('Flutter Error: ${details.exception}');
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acceso Vehicular',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        debugPrint('Navegando a: ${settings.name}');
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LandingPage());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/menu':
            return MaterialPageRoute(builder: (_) => const MenuPage());
          case '/quienes-somos':
            return MaterialPageRoute(builder: (_) => const QuienesSomosPage());
          case '/contacto':
            return MaterialPageRoute(builder: (_) => const ContactoPage());
          default:
            return MaterialPageRoute(builder: (_) => const LandingPage());
        }
      },
    );
  }
}
