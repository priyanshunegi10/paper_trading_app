import 'package:flutter/material.dart';

class WatchlistContainer extends StatelessWidget {
  String shortFormName;
  String name;
  String imagePath;
  String profitOrLoss;
  String currentprice;
  WatchlistContainer({
    super.key,
    required this.shortFormName,
    required this.name,
    required this.profitOrLoss,
    required this.imagePath,
    required this.currentprice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      margin: EdgeInsets.only(right: 10),
      height: MediaQuery.of(context).size.height / 3.5,
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
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              CircleAvatar(radius: 25, backgroundImage: AssetImage(imagePath)),
            ],
          ),
          Text(name),

          Spacer(),
          Text(
            profitOrLoss,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          Text(
            currentprice,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
