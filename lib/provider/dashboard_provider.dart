import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updatedIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
