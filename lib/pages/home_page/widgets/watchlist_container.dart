import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/market_page/widgets/minichart.dart';

class WatchlistContainer extends StatelessWidget {
  final String shortFormName;
  final String name;
  final String imagePath;
  final String profitOrLoss;
  final String currentprice;
  final List<dynamic> sparklineData;
  final bool isProfit;
  final VoidCallback? onTap;

  const WatchlistContainer({
    super.key,
    required this.shortFormName,
    required this.name,
    required this.profitOrLoss,
    required this.imagePath,
    required this.currentprice,
    required this.sparklineData,
    required this.isProfit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        margin: EdgeInsets.only(right: 10),
        height: 250,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  shortFormName,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(imagePath),
                ),
              ],
            ),
            Text(name),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: MiniChart(
                  sparklineData: sparklineData,
                  isProfit: isProfit,
                ),
              ),
            ),
            Text(
              profitOrLoss,
              style: TextStyle(
                color: profitOrLoss.startsWith('-') ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentprice,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
