import 'package:flutter/material.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';

class BottomNavbarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.25, color: context.themeColors.border),
        ),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 2.0,
        elevation: 0,
        padding: const EdgeInsets.only(top: 4),
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(icon: Icons.home, index: 0, context: context),
            _navItem(icon: Icons.history, index: 1, context: context),
            SizedBox(width: 60),
            _navItem(icon: Icons.info_outlined, index: 2, context: context),
            _navItem(icon: Icons.settings, index: 3, context: context),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required int index,
    required BuildContext context,
  }) {
    final isSelected = index == currentIndex;
    return IconButton(
      icon: Icon(
        icon,
        color:
            isSelected
                ? context.themeColors.selectedLabel
                : context.themeColors.unselectedLabel,
      ),
      onPressed: () => onTap(index),
    );
  }
}
