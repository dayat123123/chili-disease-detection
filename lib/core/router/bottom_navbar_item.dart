import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavbarItem {
  final String label;
  final Widget page;
  final List<RouteBase> routes;
  final GlobalKey<NavigatorState> navigatorKey;
  const BottomNavbarItem({
    required this.label,
    required this.page,
    this.routes = const [],
    required this.navigatorKey,
  });
}
