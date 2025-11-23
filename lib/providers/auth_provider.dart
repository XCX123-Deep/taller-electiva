import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _user;
  bool _isLoading = false;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void setUser(Map<String, dynamic> user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _token = null;
    _user = null;
    notifyListeners();
  }
}
