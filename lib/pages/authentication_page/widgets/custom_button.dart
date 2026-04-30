import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? ontap;

  const CustomButton({super.key, required this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,

        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
