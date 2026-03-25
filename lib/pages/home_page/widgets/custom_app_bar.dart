import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paper_trading_app/services/firebase_storage_services.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          CircleAvatar(radius: 25, child: Image.asset("assets/icons/man.png")),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                  ),
                  SizedBox(width: 5),
                  Image.asset("assets/icons/hello.png", height: 23),
                ],
              ),

              // StreamBuilder<DocumentSnapshot>(
              //   stream: FirebaseStorageServices().getUserProfile(),
              //   builder: (context, snapshort) {
              //     if (snapshort.connectionState == ConnectionState.waiting) {
              //       return Center(child: CircularProgressIndicator());
              //     }

              //     if (snapshort.hasData && snapshort.data!.exists) {
              //       String _userName = snapshort.data!.get('');
              //     }
              Text(
                "Priyanshu negi",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //   },
              // ),
            ],
          ),
          Spacer(),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset("assets/icons/bell.png"),
            ),
          ),
        ],
      ),
    );
  }
}
