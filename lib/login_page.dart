import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedRole;
  bool _isBiometricAvailable = false;
  bool _isAuthenticating = false;
  bool _isLoggingIn = false;
  late LocalAuthentication auth;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final isDeviceSupported = await auth.canCheckBiometrics;
      
      setState(() {
        _isBiometricAvailable = isDeviceSupported;
      });

      if (isDeviceSupported) {
        List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();
        debugPrint('Biometría disponible: $availableBiometrics');
      }
    } catch (e) {
      debugPrint('Error al verificar biometría: $e');
      setState(() {
        _isBiometricAvailable = false;
      });
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    if (!_isBiometricAvailable) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biometría no disponible en este dispositivo'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      setState(() {
        _isAuthenticating = true;
      });

      final isAuthenticated = await auth.authenticate(
        localizedReason: 'Escanea tu huella digital para iniciar sesión',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (!mounted) return;

      setState(() {
        _isAuthenticating = false;
      });

      if (isAuthenticated) {
        // Mostrar modal de selección de rol
        _showRoleSelectionModal();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isAuthenticating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error en autenticación biométrica: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showRoleSelectionModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String? tempRole = selectedRole;
        return AlertDialog(
          title: const Text('Selecciona tu Rol'),
          content: DropdownButtonFormField<String>(
            value: tempRole,
            decoration: InputDecoration(
              hintText: "Seleccionar Rol",
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: Colors.black12, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: Color(0xFF1565C0), width: 1.8),
              ),
            ),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            items: const [
              DropdownMenuItem(
                value: "Administrador",
                child: Text("Administrador"),
              ),
              DropdownMenuItem(
                value: "Residente",
                child: Text("Residente"),
              ),
              DropdownMenuItem(
                value: "Portero",
                child: Text("Portero"),
              ),
            ],
            onChanged: (value) {
              tempRole = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (tempRole != null) {
                  setState(() {
                    selectedRole = tempRole;
                  });
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/menu');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor selecciona un rol'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _login() async {
    // Validar que los campos estén completos
    if (userController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoggingIn = true;
    });

    // Intentar login con MongoDB
    final result = await AuthService.login(
      username: userController.text,
      password: passwordController.text,
      role: selectedRole!,
    );

    setState(() {
      _isLoggingIn = false;
    });

    if (!mounted) return;

    if (result['success']) {
      // Login exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bienvenido ${result['user']['username']}'),
          backgroundColor: Colors.green,
        ),
      );
      // Guardar token si lo necesitas
      // Aquí puedes guardar en SharedPreferences si lo deseas
      
      // Navegar al menú
      Navigator.pushReplacementNamed(context, '/menu');
    } else {
      // Error en login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${result['message']}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _goBack() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D47A1), // Azul profundo corporativo
              Color(0xFF1565C0), // Azul medio elegante
              Color(0xFF1E88E5), // Azul más claro para el degradado
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.6, 1.0], // Control del flujo del degradado
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.lock, color: Colors.white, size: 80),
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  "Bienvenido a Safe Entry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 30),

                // BOTÓN BIOMÉTRICO - Si está disponible
                if (_isBiometricAvailable)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isAuthenticating
                              ? null
                              : _authenticateWithBiometrics,
                          icon: _isAuthenticating
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.fingerprint, size: 28),
                          label: Text(
                            _isAuthenticating
                                ? 'Escaneando...'
                                : 'Iniciar con Huella Digital',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BCD4),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'o inicia sesión con usuario y contraseña',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                // FORMULARIO COMPACTO
                Container(
                  width: 340,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Campo Usuario
                      TextField(
                        controller: userController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline,
                              color: Colors.grey),
                          hintText: "Usuario",
                          hintStyle: const TextStyle(
                              color: Colors.black45, fontSize: 15),
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF1565C0), width: 1.8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo Contraseña
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Colors.grey),
                          hintText: "Contraseña",
                          hintStyle: const TextStyle(
                              color: Colors.black45, fontSize: 15),
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF1565C0), width: 1.8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo Rol (Dropdown)
                      DropdownButtonFormField<String>(
                        value: selectedRole,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.account_circle,
                              color: Colors.grey),
                          hintText: "Seleccionar Rol",
                          hintStyle: const TextStyle(
                              color: Colors.black45, fontSize: 15),
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF1565C0), width: 1.8),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        items: const [
                          DropdownMenuItem(
                            value: "Administrador",
                            child: Text("Administrador"),
                          ),
                          DropdownMenuItem(
                            value: "Residente",
                            child: Text("Residente"),
                          ),
                          DropdownMenuItem(
                            value: "Portero",
                            child: Text("Portero"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),

                      // Botón Iniciar Sesión
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoggingIn ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D47A1),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: _isLoggingIn
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Iniciar Sesión",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextButton(
                        onPressed: _goBack,
                        child: const Text(
                          "← Volver a la página principal",
                          style: TextStyle(
                            color: Color(0xFF1565C0),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
