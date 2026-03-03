import 'package:flutter/material.dart';
import 'package:paper_trading_app/provider/nav_provider.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationbar extends StatelessWidget {
  const MyBottomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<NavProvider>().currentIndex;

    List<String> iconsPaths = [
      "assets/icons/home.png",
      "assets/icons/line-chart.png",
      "assets/icons/wallet.png",
      "assets/icons/setting.png",
    ];
    double alignmentX = -1.0 + (2.0 * currentIndex / (iconsPaths.length - 1));

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            alignment: Alignment(alignmentX, 0),
            child: Container(
              width:
                  (MediaQuery.of(context).size.width - 40) / iconsPaths.length,
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFB1F041),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              iconsPaths.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<NavProvider>().updateIndex(index);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: SizedBox(
                      height: 35,
                      child: Image.asset(
                        iconsPaths[index],
                        color:
                            context.watch<NavProvider>().currentIndex == index
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
