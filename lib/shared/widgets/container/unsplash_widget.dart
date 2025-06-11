import 'package:flutter/material.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';

class UnsplashWidget extends StatelessWidget {
  final Widget child;
  final bool isTransparentDivierColor;
  const UnsplashWidget({
    super.key,
    required this.child,
    this.isTransparentDivierColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.theme.copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        dividerColor: isTransparentDivierColor ? Colors.transparent : null,
        highlightColor: Colors.transparent,
      ),
      child: child,
    );
  }
}
