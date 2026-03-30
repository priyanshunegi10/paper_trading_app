import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:paper_trading_app/pages/market_page/action_toggle_button_market.dart';
import 'package:paper_trading_app/pages/market_page/widgets/stocks_card.dart';
import 'package:paper_trading_app/provider/dashboard_provider.dart';
import 'package:paper_trading_app/provider/nav_provider.dart';
import 'package:provider/provider.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  Timer? _marketTimer;

  @override
  void initState() {
    super.initState();

    context.read<NavProvider>().addListener(_checkAndManageTimer);
  }

  void _checkAndManageTimer() {
    final currentIndex = context.read<NavProvider>().currentIndex;

    if (currentIndex == 1) {
      if (_marketTimer == null || !_marketTimer!.isActive) {
        context.read<DashboardProvider>().fetchMarketData();

        _marketTimer = Timer.periodic(Duration(seconds: 60), (timer) {
          context.read<DashboardProvider>().fetchMarketData();
        });
      }
    } else {
      if (_marketTimer != null && _marketTimer!.isActive) {
        _marketTimer!.cancel();
        _marketTimer = null;
      }
    }
  }

  @override
  void dispose() {
    _marketTimer?.cancel();
    context.read<NavProvider>().removeListener(_checkAndManageTimer);
    super.dispose();
  }

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
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
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

                                return Slidable(
                                  key: ValueKey(coin.id),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          context
                                              .read<DashboardProvider>()
                                              .addToWatchlist(coin.id);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).clearSnackBars();

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${coin.name} Watchlist mein add ho gaya!',
                                              ),
                                              backgroundColor:
                                                  Colors.green.shade700,
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                            ),
                                          );
                                        },
                                        backgroundColor: const Color(
                                          0xFF21B7CA,
                                        ),
                                        foregroundColor: Colors.white,
                                        icon: Icons.star,
                                        label: 'Add',
                                      ),
                                    ],
                                  ),
                                  child: StocksCard(
                                    imagePath: coin.image,
                                    shortFormName: coin.symbol,
                                    stockName: coin.name,
                                    stockPrice: "\$${coin.current_price}",
                                    profitLoss:
                                        "${coin.price_change_percentage_24h > 0 ? "+" : ""}${coin.price_change_percentage_24h.toStringAsFixed(2)}%",
                                  ),
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
