import 'package:flutter/material.dart';

class ActionToggleWidgetMarkrt extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const ActionToggleWidgetMarkrt({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> options = ['All', 'Top Gainers', 'Top Losers'];
    double alignmentX = -1.0 + (2.0 * selectedIndex / (options.length - 1));
    return Container(
      padding: EdgeInsets.all(10),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            alignment: Alignment(alignmentX, 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth / options.length,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB1F041),
                    borderRadius: BorderRadius.circular(30),
                  ),
                );
              },
            ),
          ),
          Row(
            children: List.generate(
              options.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.black
                            : Colors.grey.shade500,
                        fontWeight: selectedIndex == index
                            ? FontWeight.bold
                            : FontWeight.w600,
                        fontSize: 15,
                      ),
                      child: Text(options[index]),
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
