import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String baseUrl = 'http://192.168.1.10:3000/api/auth';
  
  // Cambiar YOUR_SERVER_IP por tu IP local o servidor en producción
  // Ejemplo: http://192.168.1.100:3000/api/auth

  /// Registrar nuevo usuario
  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Usuario registrado exitosamente',
          'data': jsonDecode(response.body),
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error en el registro',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e',
      };
    }
  }

  /// Login con usuario y contraseña
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'Login exitoso',
          'token': data['token'],
          'user': data['user'],
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['error'] ?? 'Error en el login',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e',
      };
    }
  }

  /// Verificar token (para biometría)
  static Future<Map<String, dynamic>> verifyToken({
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'Token válido',
          'user': data['user'],
        };
      } else {
        return {
          'success': false,
          'message': 'Token inválido o expirado',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: $e',
      };
    }
  }
}
