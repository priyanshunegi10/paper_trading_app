import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/home_page/widgets/action_toggle_widget.dart';
import 'package:paper_trading_app/pages/home_page/widgets/custom_app_bar.dart';
import 'package:paper_trading_app/pages/home_page/widgets/transactions_widget.dart';
import 'package:paper_trading_app/pages/home_page/widgets/watchlist_container.dart';
import 'package:paper_trading_app/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffDCE6FE), Color(0xffF9FBFC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Current Balance",
                  style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "\$100000.00",
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                    Spacer(),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Text(
                              "USD",
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_drop_down),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xffF9FBFC), Color(0xffDCE6FE)],
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 25,
                                left: 25,
                                right: 25,
                              ),
                              child: ActionToggleWidget(
                                selectedIndex: context
                                    .watch<DashboardProvider>()
                                    .currentIndex,
                                onChanged: (index) {
                                  context
                                      .read<DashboardProvider>()
                                      .updatedIndex(index);
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "WatchList",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Spacer(),
                                  Text(
                                    "See All",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Row(
                                  children: [
                                    WatchlistContainer(
                                      shortFormName: "BTC",
                                      name: "bitcoin",
                                      imagePath: "assets/icons/man.png",
                                      profitOrLoss: "+1.4%",
                                      currentprice: "\$45,561.50",
                                    ),
                                    WatchlistContainer(
                                      shortFormName: "BTC",
                                      name: "bitcoin",
                                      imagePath: "assets/icons/man.png",
                                      profitOrLoss: "+1.4%",
                                      currentprice: "\$45,561.50",
                                    ),
                                    WatchlistContainer(
                                      shortFormName: "BTC",
                                      name: "bitcoin",
                                      imagePath: "assets/icons/man.png",
                                      profitOrLoss: "+1.4%",
                                      currentprice: "\$45,561.50",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Transactions",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "See All",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),

                            TransactionsWidget(
                              imagePath: "assets/icons/man.png",
                              name: "Priyanshu negi",
                              dateTime: "01 NOV, 2026",
                              quantity: "0.036",
                              profitLoss: "-\$100.00",
                            ),

                            SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
