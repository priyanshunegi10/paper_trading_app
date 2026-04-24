import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paper_trading_app/pages/wallet_page/widgets/profit_loss_card.dart';
import 'package:paper_trading_app/pages/wallet_page/widgets/stocks_card.dart';
import 'package:paper_trading_app/provider/dashboard_provider.dart';
import 'package:paper_trading_app/services/firebase_storage_services.dart';

class WalletPage extends StatelessWidget {
  final FirebaseStorageServices _dbServices = FirebaseStorageServices();

  WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffDCE6FE), Color(0xffF9FBFC)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Holdings",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),

                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _dbServices.getPortfolioStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      );
                    }

                    var portfolioCoins = snapshot.data ?? [];

                    if (portfolioCoins.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "You have no holdings. Buy some coins.",
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return Consumer<DashboardProvider>(
                      builder: (context, provider, _) {
                        double totalInvested = 0.0;
                        double totalCurrentValue = 0.0;

                        for (var dbCoin in portfolioCoins) {
                          double qty = (dbCoin['quantity'] as num).toDouble();
                          double buyPrice = (dbCoin['buyPrice'] as num)
                              .toDouble();

                          int coinIndex = provider.cryptoList.indexWhere(
                            (apiCoin) => apiCoin.id == dbCoin['coinId'],
                          );
                          var liveCoinData = coinIndex != -1
                              ? provider.cryptoList[coinIndex]
                              : null;
                          double livePrice = liveCoinData != null
                              ? liveCoinData.current_price
                              : 0.0;

                          totalInvested += (qty * buyPrice);
                          totalCurrentValue += (qty * livePrice);
                        }

                        double totalPnl = totalCurrentValue - totalInvested;
                        double totalPnlPercentage = totalInvested > 0
                            ? (totalPnl / totalInvested) * 100
                            : 0.0;
                        bool isProfit = totalPnl > 0;
                        return Column(
                          children: [
                            ProfitLossCard(
                              investedAmount:
                                  "\$${totalInvested.toStringAsFixed(2)}",
                              currentAmount:
                                  "\$${totalCurrentValue.toStringAsFixed(2)}",
                              currentProfitLoss:
                                  "${totalPnl >= 0 ? '+' : ''}\$${totalPnl.toStringAsFixed(2)}",
                              currnetProfitLossPercentange:
                                  "(${totalPnl >= 0 ? '+' : ''}${totalPnlPercentage.toStringAsFixed(2)}%)",
                              isProfit: isProfit,
                            ),

                            const SizedBox(height: 20),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: portfolioCoins.length,
                              itemBuilder: (context, index) {
                                var dbCoin = portfolioCoins[index];

                                int coinIndex = provider.cryptoList.indexWhere(
                                  (apiCoin) => apiCoin.id == dbCoin['coinId'],
                                );

                                var liveCoinData = coinIndex != -1
                                    ? provider.cryptoList[coinIndex]
                                    : null;

                                double livePrice = liveCoinData != null
                                    ? liveCoinData.current_price
                                    : 0.0;
                                double currentPrice = liveCoinData != null
                                    ? liveCoinData.current_price
                                    : 0.0;
                                double marketChangePer = liveCoinData != null
                                    ? liveCoinData.price_change_percentage_24h
                                    : 0.0;
                                double stockQty = dbCoin['quantity'];
                                double buyPrice = dbCoin['buyPrice'];

                                double investedAmount = stockQty * buyPrice;
                                double doubleMarketChange = currentPrice;

                                bool isProfit =
                                    investedAmount > doubleMarketChange;
                                return StocksCard(
                                  quantity: (dbCoin['quantity'] as num)
                                      .toDouble(),
                                  name: dbCoin['symbol'].toUpperCase(),
                                  buyPrice: (dbCoin['buyPrice'] as num)
                                      .toDouble(),
                                  currentLivePrice: livePrice,
                                  market24hChange: currentPrice,
                                  market24hChangePercentage: marketChangePer,
                                  isProfit: isProfit,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
