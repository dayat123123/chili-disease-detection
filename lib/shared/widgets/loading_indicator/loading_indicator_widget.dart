import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final double? value;
  final double? scale;
  final double strokeWidth;
  const LoadingIndicatorWidget({
    super.key,
    this.value,
    this.strokeWidth = 4.0,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale ?? 1,
      child:
          Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator(
                value: value,
                strokeWidth: strokeWidth,
              ),
    );
  }
}
