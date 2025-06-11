import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chili_disease_detection/core/router/bottom_navbar_item.dart';
import 'package:chili_disease_detection/core/router/route_path.dart';
import 'package:chili_disease_detection/features/main_wrapper/presentation/widgets/bottom_navbar_widget.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';

class MainWrapperPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<BottomNavbarItem> listItem;
  const MainWrapperPage({
    super.key,
    required this.navigationShell,
    required this.listItem,
  });

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  @override
  void initState() {
    super.initState();
  }

  void _onTapFloatButton() {
    context.push(RoutePath.imagePickerPath);
  }

  void _onTapNavbarIndex(int index) {
    final navigatorKey = widget.listItem[index].navigatorKey;
    if (widget.navigationShell.currentIndex == index) {
      final navigatorState = navigatorKey.currentState;
      if (navigatorState != null && navigatorState.canPop()) {
        navigatorState.popUntil((route) => route.isFirst);
      }
    } else {
      widget.navigationShell.goBranch(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: BottomNavbarWidget(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: _onTapNavbarIndex,
        ),
        floatingActionButton: SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            onPressed: _onTapFloatButton,
            backgroundColor: context.themeColors.primaryColor,
            shape: const CircleBorder(),
            child: const Icon(Icons.qr_code_scanner, size: 28),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
