import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/home_page/home_page.dart';
import 'package:paper_trading_app/pages/market_page/market_page.dart';
import 'package:paper_trading_app/pages/profile_page/profile_page.dart';
import 'package:paper_trading_app/pages/wallet_page/wallet_page.dart';
import 'package:paper_trading_app/provider/nav_provider.dart';
import 'package:paper_trading_app/widgets/my_bottom_navigationbar.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<NavProvider>().currentIndex;

    final List<Widget> _pages = [
      const HomePage(),
      const MarketPage(),
      const WalletPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: const MyBottomNavigationbar(),
      ),
    );
  }
}
