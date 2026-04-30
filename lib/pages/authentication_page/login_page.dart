import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/authentication_page/sign_up.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Image.asset("assets/images/login.png"),
              ),
              SizedBox(height: 10),
              Text("Login to your account", style: TextStyle(fontSize: 22)),
              SizedBox(height: 10),
              Text("Welcome back you've been missed"),
              SizedBox(height: 20),
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
                  prefixIcon: Icon(Icons.lock),

                  hintText: "Entre your password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
              SizedBox(height: 30),
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
