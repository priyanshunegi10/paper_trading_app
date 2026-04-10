import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/wallet_page/widgets/profit_loss_card.dart';
import 'package:paper_trading_app/pages/wallet_page/widgets/stocks_card.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffDCE6FE), Color(0xffF9FBFC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "Holdings",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              ProfitLossCard(
                currentAmount: "\$98000",
                currentProfitLoss: "-200.20",
                currnetProfitLossPercentange: "-2.3%",
                investedAmount: "\$10000",
              ),

              StocksCard(
                quantity: "10",
                averagePrice: "\$1000.00",
                currentLossOrProfitInPerce: "+2.32%",
                name: "Bitcoin",
                currentLossOrProfit: "\$200.20",
                investedAmount: "\$1000.20",
                priceChangeIn24houres: "\$200.20",
                priceChangeIn24houresInPercentage: "(2.1%)",
              ),
              StocksCard(
                quantity: "10",
                averagePrice: "\$1000.00",
                currentLossOrProfitInPerce: "+2.32%",
                name: "Bitcoin",
                currentLossOrProfit: "\$200.20",
                investedAmount: "\$1000.20",
                priceChangeIn24houres: "\$200.20",
                priceChangeIn24houresInPercentage: "(2.1%)",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
