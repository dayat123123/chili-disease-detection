import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:flutter/material.dart';

class ColorOpacityContainer extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle? style;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool withBorder;
  const ColorOpacityContainer({
    super.key,
    required this.text,
    required this.color,
    this.style,
    this.fontSize,
    this.horizontalPadding,
    this.verticalPadding,
    this.width,
    this.height,
    this.withBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: withBorder ? Border.all(color: color, width: 0.5) : null,
        color: color.withValues(alpha: 0.15),
        borderRadius: AppBorderRadius.medium,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 4,
        vertical: verticalPadding ?? 0.0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
