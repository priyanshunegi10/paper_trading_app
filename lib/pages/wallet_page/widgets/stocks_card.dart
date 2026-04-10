import 'package:flutter/material.dart';

class StocksCard extends StatelessWidget {
  final String quantity;
  final String averagePrice;
  final String currentLossOrProfitInPerce;
  final String name;
  final String currentLossOrProfit;
  final String investedAmount;
  final String priceChangeIn24houres;
  final String priceChangeIn24houresInPercentage;
  const StocksCard({
    super.key,
    required this.quantity,
    required this.averagePrice,
    required this.currentLossOrProfitInPerce,
    required this.name,
    required this.currentLossOrProfit,
    required this.investedAmount,
    required this.priceChangeIn24houres,
    required this.priceChangeIn24houresInPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            children: [
              Text("Qty. $quantity", style: TextStyle(fontSize: 15)),
              SizedBox(width: 10),
              Text("• Avg. $averagePrice", style: TextStyle(fontSize: 15)),
              Spacer(),
              Text(currentLossOrProfitInPerce, style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Spacer(),
              Text(
                currentLossOrProfit,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text("Invested", style: TextStyle(fontSize: 15)),
              SizedBox(width: 10),
              Text(investedAmount),
              Spacer(),
              Text(priceChangeIn24houres),
              SizedBox(width: 10),
              Text(priceChangeIn24houresInPercentage),
            ],
          ),
        ),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}
