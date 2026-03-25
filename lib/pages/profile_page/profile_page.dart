import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/authentication_page/sign_up.dart';
import 'package:paper_trading_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.read<MyAuthProvider>().logout();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text("Logout", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
