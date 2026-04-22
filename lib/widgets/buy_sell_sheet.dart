import 'package:flutter/material.dart';
import 'package:paper_trading_app/provider/portfolio_provider.dart';
import 'package:provider/provider.dart';

class BuySellSheet extends StatefulWidget {
  final String coinId;
  final String symbol;
  final String coinName;
  final double currentPrice;

  const BuySellSheet({
    super.key,
    required this.coinName,
    required this.currentPrice,
    required this.coinId,
    required this.symbol,
  });

  @override
  State<BuySellSheet> createState() => _BuySellSheetState();
}

class _BuySellSheetState extends State<BuySellSheet> {
  final TextEditingController _quantityController = TextEditingController();
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _quantityController.addListener(_calculateTotal);
  }

  void _calculateTotal() {
    if (_quantityController.text.isEmpty) {
      setState(() => _totalPrice = 0.0);
      return;
    }
    double? qty = double.tryParse(_quantityController.text);
    if (qty != null) {
      setState(() {
        _totalPrice = qty * widget.currentPrice;
      });
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trade ${widget.coinName}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${widget.currentPrice.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            Text("Total amount : \$${_totalPrice.toStringAsFixed(2)}"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () async {
                    String stringQuantity = _quantityController.text.trim();
                    double? doubleQuantity = double.tryParse(stringQuantity);

                    if (doubleQuantity == null || doubleQuantity.isNegative) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a valid quantity!"),
                        ),
                      );
                      return;
                    }
                    bool success = await context
                        .read<PortfolioProvider>()
                        .buyCoin(
                          widget.coinId,
                          widget.symbol,
                          widget.currentPrice,
                          doubleQuantity,
                        );

                    if (success) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Coin bought successfully!"),
                        ),
                      );
                      print("Sach mein Buy successfully hua!");
                    } else {
                      String errorMsg = context
                          .read<PortfolioProvider>()
                          .errorMessage;

                      print("Firebase Error: $errorMsg");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Failed: $errorMsg"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text("BUY", style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    String stringQuantity = _quantityController.text.trim();
                    double? doubleQuantity = double.tryParse(stringQuantity);

                    if (doubleQuantity == null || doubleQuantity.isNegative) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please enter a valid quantity!"),
                        ),
                      );
                    }

                    bool success = await context
                        .read<PortfolioProvider>()
                        .sellCoin(
                          widget.coinId,
                          widget.currentPrice,
                          doubleQuantity!,
                        );

                    if (success && context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Coin sell successfully!")),
                      );
                    }
                    print("sell successfully");
                  },
                  child: Text("SELL", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
