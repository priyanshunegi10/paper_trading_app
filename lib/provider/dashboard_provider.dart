import 'package:flutter/material.dart';
import 'package:paper_trading_app/model/crypto_model.dart';
import 'package:paper_trading_app/services/api_services.dart';

class DashboardProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updatedIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  final ApiServices _apiServices = ApiServices();
  List<CryptoModel> _cryptoModel = [];
  String _errorMessage = "";
  bool _isLoading = false;

  List<CryptoModel> get cryptoList => _cryptoModel;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  DashboardProvider() {
    fetchMarketData();
  }

  Future<bool> fetchMarketData() async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();
    try {
      _cryptoModel = await _apiServices.getData();
      _errorMessage = "";
      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = 'Bhai internet check kar: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
