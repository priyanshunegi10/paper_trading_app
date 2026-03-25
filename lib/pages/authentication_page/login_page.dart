import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/authentication_page/widgets/custom_button.dart';
import 'package:paper_trading_app/provider/auth_provider.dart';
import 'package:paper_trading_app/root_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page", style: TextStyle(fontSize: 30)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),

                hintText: "Entre your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            SizedBox(height: 50),
            context.watch<MyAuthProvider>().isloading
                ? const CircularProgressIndicator(color: Colors.blue)
                : CustomButton(
                    title: "Login",
                    ontap: () async {
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all the given fields"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      bool success = await context
                          .read<MyAuthProvider>()
                          .signin(email, password);

                      if (!success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context.read<MyAuthProvider>().errorMessage,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => RootPage()),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
