import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paper_trading_app/firebase_options.dart';
import 'package:paper_trading_app/pages/authentication_page/sign_up.dart';
import 'package:paper_trading_app/provider/auth_provider.dart';
import 'package:paper_trading_app/provider/dashboard_provider.dart';
import 'package:paper_trading_app/provider/nav_provider.dart';
import 'package:paper_trading_app/root_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => MyAuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            Future.microtask(
              () =>
                  context.read<DashboardProvider>().startListeningToWatchlist(),
            );

            return const RootPage();
          } else {
            return const SignUp();
          }
        },
      ),
    );
  }
}
