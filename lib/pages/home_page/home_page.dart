import 'package:flutter/material.dart';
import 'package:paper_trading_app/widgets/my_bottom_navigationbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [MyBottomNavigationbar()],
      ),
    );
  }
}
