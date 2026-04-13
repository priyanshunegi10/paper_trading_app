import 'package:flutter/material.dart';
import 'package:paper_trading_app/services/firebase_storage_services.dart';

class PortfolioProvider extends ChangeNotifier {
  final FirebaseStorageServices _dbServices = FirebaseStorageServices();

  String _errorMessage = "";
  bool _isLoading = false;

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<bool> buyCoin(
    String coinId,
    String symbol,
    double coinPrice,
    double quantity,
  ) async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      await _dbServices.buyCoin(coinId, symbol, coinPrice, quantity);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
