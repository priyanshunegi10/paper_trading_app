import 'package:flutter/material.dart';

class StocksCard extends StatelessWidget {
  final String name;
  final double quantity;
  final double buyPrice;
  final double currentLivePrice;
  final double market24hChange;
  final double market24hChangePercentage;

  const StocksCard({
    super.key,
    required this.quantity,
    required this.name,
    required this.buyPrice,
    required this.currentLivePrice,
    required this.market24hChange,
    required this.market24hChangePercentage,
  });

  @override
  Widget build(BuildContext context) {
    double investedAmount = quantity * buyPrice;
    double currentValue = quantity * currentLivePrice;
    double pnl = currentValue - investedAmount;
    double pnlPercentage = (pnl / investedAmount) * 100;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            children: [
              Text("Qty. $quantity", style: TextStyle(fontSize: 15)),
              SizedBox(width: 10),
              Text("• Avg. $buyPrice", style: TextStyle(fontSize: 15)),
              Spacer(),
              Text(
                pnlPercentage.toStringAsFixed(2),
                style: TextStyle(fontSize: 15),
              ),
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
                currentValue.toStringAsFixed(2),
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
              Text(investedAmount.toStringAsFixed(2)),
              Spacer(),
              Text(market24hChange.toStringAsFixed(2)),
              SizedBox(width: 10),
              Text(market24hChangePercentage.toStringAsFixed(2)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}
