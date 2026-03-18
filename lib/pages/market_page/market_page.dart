import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/market_page/action_toggle_button_market.dart';
import 'package:paper_trading_app/pages/market_page/widgets/stocks_card.dart';
import 'package:paper_trading_app/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffDCE6FE), Color(0xffF9FBFC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Market",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/icons/search.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ActionToggleWidgetMarkrt(
                  selectedIndex: context
                      .watch<DashboardProvider>()
                      .currentIndex,
                  onChanged: (index) {
                    context.read<DashboardProvider>().updatedIndex(index);
                  },
                ),
              ),

              SizedBox(height: 20),

              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),

                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xffF9FBFC), Color(0xffDCE6FE)],
                        ),
                      ),
                      child: Consumer<DashboardProvider>(
                        builder: (context, provider, _) {
                          if (provider.isLoading) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (provider.errorMessage.isNotEmpty) {
                            return Center(child: Text(provider.errorMessage));
                          }

                          if (provider.currentMarketList.isEmpty) {
                            return Center(child: Text("there is no data"));
                          }

                          return SizedBox(
                            height: double.infinity,
                            child: ListView.builder(
                              itemCount: provider.currentMarketList.length,
                              itemBuilder: (context, index) {
                                final coin = provider.currentMarketList[index];

                                return StocksCard(
                                  imagePath: coin.image,
                                  shortFormName: coin.symbol,
                                  stockName: coin.name,
                                  stockPrice: "\$${coin.current_price}",
                                  profitLoss:
                                      "${coin.price_change_percentage_24h > 0 ? "+" : ""}${coin.price_change_percentage_24h.toStringAsFixed(2)}%",
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
