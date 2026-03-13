import 'package:flutter/material.dart';

class StocksCard extends StatelessWidget {
  String imagePath;
  String shortFormName;
  String stockName;
  String stockPrice;
  String profitLoss;

  StocksCard({
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
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          CircleAvatar(radius: 27, child: Image.asset(imagePath)),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shortFormName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              Text(stockName, style: TextStyle(color: Colors.blueGrey)),
            ],
          ),

          Spacer(),

          Column(
            children: [
              Text(stockPrice, style: TextStyle(fontWeight: FontWeight.bold)),

              Text(
                profitLoss,
                style: TextStyle(
                  color: Colors.green,
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
