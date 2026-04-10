import 'package:flutter/material.dart';
import 'package:paper_trading_app/services/firebase_storage_services.dart';

class PortfolioProvider extends ChangeNotifier {
  final FirebaseStorageServices _firebaseStorageServices =
      FirebaseStorageServices();

  String _errorMessage = "";
  bool _isLoading = false;

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;


  
}
