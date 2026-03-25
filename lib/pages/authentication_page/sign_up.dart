import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/authentication_page/login_page.dart';
import 'package:paper_trading_app/pages/authentication_page/widgets/custom_button.dart';
import 'package:paper_trading_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        title: Text("Sign up", style: TextStyle(fontSize: 30)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("already have an account", style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Login", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            context.watch<MyAuthProvider>().isloading
                ? const CircularProgressIndicator(color: Colors.blue)
                : CustomButton(
                    title: "Signup",
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
                          .signUp(email, password);

                      if (!success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context.read<MyAuthProvider>().errorMessage,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
