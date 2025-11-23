import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: const Text(
          'Menú Principal',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white, size: 20),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3, // ✅ 3 por fila
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1, // proporción cuadrada
            children: [
              _menuItem(Icons.directions_car, 'Vehículo', Colors.blue),
              _menuItem(Icons.people, 'Residentes', Colors.green),
              _menuItem(Icons.qr_code, 'Placas', Colors.orange),
              _menuItem(Icons.bar_chart, 'Reportes', Colors.purple),
              _menuItem(Icons.settings, 'Config', Colors.grey),
              _menuItem(Icons.security, 'Seguridad', Colors.redAccent),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, Color color) {
    return SizedBox(
      width: 65, // 🔹 tamaño mínimo equilibrado
      height: 65,
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 22), // 🔹 ícono más pequeño
                const SizedBox(height: 4),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 9, // 🔹 texto reducido pero legible
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
