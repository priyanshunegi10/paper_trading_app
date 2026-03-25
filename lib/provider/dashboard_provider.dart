import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:paper_trading_app/model/crypto_model.dart';
import 'package:paper_trading_app/services/api_services.dart';
import 'package:paper_trading_app/services/firebase_storage_services.dart';

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

  // watchList
  final FirebaseStorageServices _dbService = FirebaseStorageServices();
  List<String> _watchlist = [];
  StreamSubscription? _watchlistSubscription;

  void startListeningToWatchlist() {
    _watchlistSubscription?.cancel();
    _watchlistSubscription = _dbService.getWatchlist().listen((ids) {
      _watchlist = ids;
      notifyListeners();
    });
  }

  List<CryptoModel> get myWatchlist {
    return _cryptoModel.where((coin) => _watchlist.contains(coin.id)).toList();
  }

  Future<void> addToWatchlist(String coinId) async {
    try {
      await _dbService.addCoinToWatchlist(coinId);
    } catch (e) {
      if (kDebugMode) {
        print("Add karne mein error: $e");
      }
    }
  }

  List<CryptoModel> get cryptoList => _cryptoModel;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  List<CryptoModel> get topGaines {
    List<CryptoModel> gainers = _cryptoModel
        .where((coin) => coin.price_change_percentage_24h > 0)
        .toList();

    gainers.sort(
      (a, b) => b.price_change_percentage_24h.compareTo(
        a.price_change_percentage_24h,
      ),
    );

    return gainers;
  }

  List<CryptoModel> get topLoser {
    List<CryptoModel> losers = _cryptoModel
        .where((coin) => coin.price_change_percentage_24h < 0)
        .toList();

    losers.sort(
      (a, b) => b.price_change_percentage_24h.compareTo(
        a.price_change_percentage_24h,
      ),
    );

    return losers;
  }

  List<CryptoModel> get currentMarketList {
    if (_currentIndex == 0) {
      return _cryptoModel;
    } else if (_currentIndex == 1) {
      return topGaines;
    } else if (_currentIndex == 2) {
      return topLoser;
    } else {
      return _cryptoModel;
    }
  }

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

  // BUY COIN FUNCTION

  Future<bool> buyCrypto(
    String coinId,
    String symbol,
    double coinPrice,
    double quantity,
  ) async {
    if (quantity <= 0) {
      _errorMessage = "Quantity 0 se badi honi chahiye bhai!";
      notifyListeners();
      return false;
    }
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      await _dbService.buyCoin(coinId, symbol, coinPrice, quantity);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception:", "").trim();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
