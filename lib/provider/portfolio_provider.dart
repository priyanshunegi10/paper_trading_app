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
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sellCoin(
    String coinId,
    double currentMarketPrice,
    double quantityToSell,
  ) async {
    _errorMessage = '';
    _isLoading = true;
    notifyListeners();

    try {
      await _dbServices.sellCoin(
        coinId,
        currentMarketPrice,
        quantityToSell,
        coinId,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
