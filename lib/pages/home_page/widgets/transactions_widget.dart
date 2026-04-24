import 'package:flutter/material.dart';

class TransactionsWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String dateTime;
  final String quantity;
  final String profitLoss;
  final bool isBuy;
  const TransactionsWidget({
    super.key,
    required this.imagePath,
    required this.name,
    required this.dateTime,
    required this.quantity,
    required this.profitLoss,
    required this.isBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: imagePath.isNotEmpty
                ? NetworkImage(imagePath)
                : const AssetImage("assets/icons/man.png") as ImageProvider,
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 18)),

              Text(dateTime, style: TextStyle(color: Colors.blueGrey)),
            ],
          ),

          Spacer(),
          Column(
            children: [
              Text(
                quantity,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                profitLoss,
                style: TextStyle(color: isBuy ? Colors.green : Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
