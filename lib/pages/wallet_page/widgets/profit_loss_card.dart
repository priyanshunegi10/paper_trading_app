import 'package:flutter/material.dart';

class ProfitLossCard extends StatelessWidget {
  final String investedAmount;
  final String currentAmount;
  final String currentProfitLoss;
  final String currnetProfitLossPercentange;
  const ProfitLossCard({
    super.key,
    required this.investedAmount,
    required this.currentAmount,
    required this.currentProfitLoss,
    required this.currnetProfitLossPercentange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Invested", style: TextStyle(fontSize: 16)),
              Text("Current", style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                investedAmount,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Text(
                currentAmount,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          Divider(),
          Row(
            children: [
              Text("P&L", style: TextStyle(fontSize: 20)),
              Spacer(),
              Text(
                currentProfitLoss,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 5),
              Text(
                currnetProfitLossPercentange,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
