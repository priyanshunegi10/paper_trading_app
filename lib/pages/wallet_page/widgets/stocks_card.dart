import 'package:flutter/material.dart';

class StocksCard extends StatelessWidget {
  final String name;
  final double quantity;
  final double buyPrice;
  final double currentLivePrice;
  final double market24hChange;
  final double market24hChangePercentage;
  final bool isProfit;
  const StocksCard({
    super.key,
    required this.quantity,
    required this.name,
    required this.buyPrice,
    required this.currentLivePrice,
    required this.market24hChange,
    required this.market24hChangePercentage,
    required this.isProfit,
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Row(
            children: [
              Text("Qty. $quantity", style: TextStyle(fontSize: 15)),
              SizedBox(width: 15),
              Text(
                "• Avg. ${buyPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 15),
              ),

              Spacer(),
              Text(
                "${pnlPercentage.toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 15,
                  color: isProfit ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5 ),
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
                  color: isProfit ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
        SizedBox(height: 5),
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
              Text(
                "${market24hChangePercentage.toStringAsFixed(2)}%",
                style: TextStyle(color: isProfit ? Colors.green : Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}
