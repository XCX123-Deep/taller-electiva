import 'package:flutter/material.dart';

class QuienesSomosPage extends StatelessWidget {
  const QuienesSomosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco

      appBar: AppBar(
        backgroundColor: const Color(0xFF3D7BF0), // Azul corporativo
        title: const Text(
          'Quiénes Somos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            // --- SECCIÓN: NUESTRA EMPRESA ---
            const Text(
              'Nuestra Empresa',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D7BF0), // Azul corporativo
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Somos una empresa dedicada a la automatización del control de acceso vehicular '
              'para conjuntos residenciales. Buscamos mejorar la seguridad, eficiencia y trazabilidad '
              'de los accesos mediante tecnologías innovadoras como reconocimiento de placas y cámaras inteligentes.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            ),

            const SizedBox(height: 30),

            // --- SECCIÓN: MISIÓN ---
            const Text(
              'Misión',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D7BF0),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ofrecer soluciones tecnológicas seguras y eficientes que optimicen la gestión del acceso vehicular en los conjuntos residenciales.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            ),

            const SizedBox(height: 30),

            // --- SECCIÓN: VISIÓN ---
            const Text(
              'Visión',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D7BF0),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ser líderes en automatización residencial en Latinoamérica, destacándonos por la innovación y confiabilidad de nuestras soluciones tecnológicas.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            ),

            const SizedBox(height: 40),

            // --- SECCIÓN: COFUNDADORES ---
            const Center(
              child: Text(
                'Cofundadores del Programa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D7BF0),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 30,
              runSpacing: 24,
              children: [
                _buildFounderCard(
                  name: 'Gabriel Borré',
                  role: 'Backend',
                ),
                _buildFounderCard(
                  name: 'María Fernanda Cogollo',
                  role: 'Frontend',
                ),
                _buildFounderCard(
                  name: 'Eliana Venecia',
                  role: 'Frontend',
                ),
              ],
            ),

            const SizedBox(height: 40),

            // --- BOTÓN VOLVER AL INICIO ---
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D7BF0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Volver a la página principal',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- FUNCIÓN: TARJETA DE COFUNDADOR ---
  Widget _buildFounderCard({
    required String name,
    required String role,
  }) {
    return SizedBox(
      width: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade50,
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Color(0xFF3D7BF0),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
