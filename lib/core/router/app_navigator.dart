import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chili_disease_detection/core/router/bottom_navbar_item.dart';
import 'package:chili_disease_detection/core/router/route_path.dart';
import 'package:chili_disease_detection/core/tensorflow/tensorflow.dart';
import 'package:chili_disease_detection/features/about/presentation/pages/about_page.dart';
import 'package:chili_disease_detection/features/analyzed/presentation/pages/analyzed_page.dart';
import 'package:chili_disease_detection/features/history/presentation/pages/history_page.dart';
import 'package:chili_disease_detection/features/home/presentation/pages/home_page.dart';
import 'package:chili_disease_detection/features/landing/presentation/pages/landing_page.dart';
import 'package:chili_disease_detection/features/main_wrapper/presentation/pages/main_wrapper_page.dart';
import 'package:chili_disease_detection/features/setting/presentation/pages/setting_page.dart';
import 'package:chili_disease_detection/features/splash/presentation/pages/splash_page.dart';
import 'package:chili_disease_detection/main.dart';
import 'package:chili_disease_detection/features/image_picker/presentation/pages/image_picker_page.dart';
import 'package:chili_disease_detection/features/full_screen_image_preview/presentation/pages/full_screen_image_view_page.dart';

class AppNavigator {
  const AppNavigator();
  static final List<BottomNavbarItem> _mainMenu = [
    BottomNavbarItem(
      label: 'Home',
      page: HomePage(),
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellHome'),
      routes: [
        GoRoute(
          path: RoutePath.homePath,
          builder: (context, state) => const HomePage(),
        ),
      ],
    ),
    BottomNavbarItem(
      label: 'History',
      page: HistoryPage(),
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellHistory'),
      routes: [
        GoRoute(
          path: RoutePath.historyPath,
          builder: (context, state) => const HistoryPage(),
        ),
      ],
    ),

    BottomNavbarItem(
      label: 'Info',
      page: AboutPage(),
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellInfo'),
      routes: [
        GoRoute(
          path: RoutePath.infoPath,
          builder: (context, state) => const AboutPage(),
        ),
      ],
    ),
    BottomNavbarItem(
      label: 'Setting',
      page: SettingPage(),
      navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellSetting'),
      routes: [
        GoRoute(
          path: RoutePath.settingPath,
          builder: (context, state) => const SettingPage(),
        ),
      ],
    ),
  ];
  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.splashPath,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: RoutePath.splashPath,
        builder: (BuildContext context, GoRouterState state) => SplashPage(),
      ),
      GoRoute(
        path: RoutePath.landingPath,
        builder: (BuildContext context, GoRouterState state) => LandingPage(),
      ),

      GoRoute(
        path: RoutePath.imagePickerPath,
        builder:
            (BuildContext context, GoRouterState state) => ImagePickerPage(),
      ),
      GoRoute(
        path: RoutePath.fullScreenImageViewPath,
        builder: (BuildContext context, GoRouterState state) {
          final File? file =
              (state.extra is File) ? (state.extra as File) : null;
          if (file == null) {
            return Scaffold(
              appBar: AppBar(title: Text('Oops')),
              body: Center(child: Text('Gambar tidak valid')),
            );
          }
          return FullScreenImageViewPage(imageFile: file);
        },
      ),
      GoRoute(
        path: RoutePath.analyzedPath,
        builder: (BuildContext context, GoRouterState state) {
          final ResultClassModel? result =
              (state.extra is ResultClassModel)
                  ? (state.extra as ResultClassModel)
                  : null;
          if (result == null) {
            return Scaffold(
              appBar: AppBar(title: Text('Oops')),
              body: Center(child: Text('Parameter tidak valid')),
            );
          }
          return AnalyzedPage(result: result);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) => MainWrapperPage(
              navigationShell: navigationShell,
              listItem: _mainMenu,
            ),
        branches:
            _mainMenu
                .map(
                  (item) => StatefulShellBranch(
                    navigatorKey: item.navigatorKey,
                    routes: item.routes,
                  ),
                )
                .toList(),
      ),
    ],
  );
}
