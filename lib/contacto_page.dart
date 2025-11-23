import 'package:flutter/material.dart';

class ContactoPage extends StatelessWidget {
  const ContactoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con color corporativo
      appBar: AppBar(
        backgroundColor: const Color(0xFF4285F4), // Azul del ejemplo
        title: const Text(
          'Contáctanos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),

      // Fondo blanco del cuerpo
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: const [
            Text(
              'Estamos aquí para ayudarte',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4285F4), // Usa el mismo azul corporativo
              ),
            ),
            SizedBox(height: 15),
            Text(
              '📍 Dirección: Calle 123 #45-67, Bogotá, Colombia\n'
              '📞 Teléfono: +57 310 123 4567\n'
              '✉️ Email: contacto@accesovehicular.com',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            ),
            SizedBox(height: 30),
            Text(
              'Si tienes alguna duda o deseas más información, no dudes en comunicarte con nuestro equipo de soporte.',
              style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
