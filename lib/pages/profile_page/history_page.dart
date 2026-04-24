import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/home_page/widgets/transactions_widget.dart';
import 'package:paper_trading_app/provider/dashboard_provider.dart';
import 'package:paper_trading_app/services/firebase_storage_services.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseStorageServices().getTranscationHistory(),
        builder: (context, snapshort) {
          if (snapshort.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var transcation = snapshort.data ?? [];

          if (transcation.isEmpty) {
            return Center(child: Text("There is no transcation histoty"));
          }

          return Consumer<DashboardProvider>(
            builder: (context, provider, _) {
              return ListView.builder(
                itemCount: transcation.length,
                itemBuilder: (context, index) {
                  var tx = transcation[index];

                  // date formate
                  Timestamp? timeStamp = tx['timeStamp'] as Timestamp?;

                  DateTime date = timeStamp != null
                      ? timeStamp.toDate()
                      : DateTime.now();
                  String formattedDate =
                      "${date.day}/${date.month}/${date.year}";

                  bool isBuy = tx['type'] == 'BUY';
                  String qtyText = "${isBuy ? '+' : '-'}${tx['quantity']}";
                  String totalAmountText =
                      "\$${(tx['totalAmount'] as num).toStringAsFixed(2)}";

                  int coinIndex = provider.cryptoList.indexWhere(
                    (apicoin) => apicoin.id == tx['coinId'],
                  );

                  String coinImage = coinIndex != -1
                      ? provider.cryptoList[coinIndex].image
                      : "";
                  return Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                          Text(
                            "History",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      TransactionsWidget(
                        imagePath: coinImage,
                        name: "${tx['symbol'].toUpperCase()} (${tx['type']})",
                        dateTime: formattedDate,
                        quantity: qtyText,
                        profitLoss: totalAmountText,
                        isBuy: isBuy,
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
