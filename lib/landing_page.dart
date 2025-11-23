import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[900]!,
              Colors.blue[700]!,
              Colors.blue[500]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),

              // Logo placeholder simple
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
                child: const Icon(Icons.shield, color: Colors.white, size: 80),
              ),
              const SizedBox(height: 50),

              // Título principal
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Automatización del Acceso Vehicular',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                    height: 1.3,
                    shadows: [
                      Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 8,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Botones de navegación
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 25,
                runSpacing: 25,
                children: [
                  _navButton(context, 'Quiénes Somos', '/quienes-somos'),
                  _navButton(context, 'Contacto', '/contacto'),
                  _navButton(context, 'Iniciar Sesión', '/login'),
                ],
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, String text, String route) {
    return ElevatedButton(
      onPressed: () {
        debugPrint('Botón presionado: $route');
        Navigator.pushReplacementNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.95),
        foregroundColor: const Color(0xFF3D7BF0),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 6,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: Color(0xFF3D7BF0),
        ),
      ),
    );
  }
}
