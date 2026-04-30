import 'package:flutter/material.dart';
import 'package:paper_trading_app/services/firebase_auth_services.dart';

class MyAuthProvider extends ChangeNotifier {
  final FirebaseAuthSevices _authSevices = FirebaseAuthSevices();

  String _errorMessage = "";
  bool _isLoading = false;

  String get errorMessage => _errorMessage;
  bool get isloading => _isLoading;

  Future<bool> signUp(String email, String password , String name) async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();
    try {
      await _authSevices.signupWithEmail(email, password ,name );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "$e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signin(String email, String password) async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      await _authSevices.loginWithEmail(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "$e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      await _authSevices.logout();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "$e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
