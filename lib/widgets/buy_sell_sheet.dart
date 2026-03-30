import 'package:flutter/material.dart';

class BuySellSheet extends StatefulWidget {
  const BuySellSheet({super.key});

  @override
  State<BuySellSheet> createState() => _BuySellSheetState();
}

class _BuySellSheetState extends State<BuySellSheet> {
  TextEditingController _quantityController = TextEditingController();
  bool _isBuy = true;
  double _totalPrice = 0.0;

  void _calculateTotal() {
    if (_quantityController.text.isEmpty) {
      setState(() => _totalPrice = 0.0);
      return;
    }
    double? qty = double.tryParse(_quantityController.text);
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
        
      ),
    );
  }
}
