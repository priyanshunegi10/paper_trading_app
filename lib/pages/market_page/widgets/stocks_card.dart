import 'package:flutter/material.dart';

class StocksCard extends StatelessWidget {
  final String imagePath;
  final String shortFormName;
  final String stockName;
  final String stockPrice;
  final String profitLoss;

  const StocksCard({
    super.key,
    required this.imagePath,
    required this.shortFormName,
    required this.stockName,
    required this.stockPrice,
    required this.profitLoss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage(imagePath),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shortFormName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(stockName, style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              Text(stockPrice, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                profitLoss,
                style: TextStyle(
                  color: profitLoss.startsWith('-') ? Colors.red : Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
