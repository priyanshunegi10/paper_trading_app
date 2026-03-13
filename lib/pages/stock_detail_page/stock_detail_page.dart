import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paper_trading_app/pages/stock_detail_page/widgets/timer_toggle_widgets.dart';
import 'package:paper_trading_app/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class StockDetailPage extends StatelessWidget {
  const StockDetailPage({super.key});

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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage("assets/icons/man.png"),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "BTC",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "+1.4%",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.star_border_purple500_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Last Traded Price",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Text(
                  "\$45,563.44",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xffF9FBFC), Color(0xffDCE6FE)],
                        ),
                      ),
                      child: Column(
                        children: [
                          TimerToggleWidgets(
                            selectedIndex: context
                                .watch<DashboardProvider>()
                                .currentIndex,
                            onChanged: (index) {
                              context.read<DashboardProvider>().updatedIndex(
                                index,
                              );
                            },
                          ),
                        ],
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
