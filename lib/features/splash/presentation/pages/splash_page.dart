import 'package:chili_disease_detection/shared/misc/file_paths.dart';
import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/router/route_path.dart';
import 'package:chili_disease_detection/injector.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      getRouter.go(RoutePath.landingPath);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          height: 200,
          width: 200,
          FilePaths.splash,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
