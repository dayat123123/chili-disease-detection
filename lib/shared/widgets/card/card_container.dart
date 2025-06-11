import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? color;
  final Color? splashColor;
  final BoxBorder? border;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final CardContainerShape shape;
  final bool withBottomMargin;
  final bool isTransparent;
  final bool withShadow;
  const CardContainer({
    super.key,
    required this.child,
    this.onTap,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    this.padding = AppPadding.horizontal,
    this.border,
    this.onLongPress,
    this.borderRadius = AppBorderRadius.mediumNumber,
    this.constraints,
    this.color,
    this.splashColor,
    this.shape = CardContainerShape.rounded,
    this.isTransparent = false,
    this.withBottomMargin = false,
    this.withShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: withBottomMargin ? const EdgeInsets.only(bottom: 3) : null,
      decoration: _boxDecoration(context),
      child: Material(
        shape: _shapeBorder(),
        color:
            isTransparent
                ? Colors.transparent
                : color ?? context.themeColors.appContainerBackground,
        borderRadius: _borderRadiusGeometry(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          enableFeedback: true,
          onLongPress: onLongPress,
          splashColor:
              splashColor ??
              context.themeColors.primaryColor.withValues(alpha: 0.05),
          hoverColor:
              splashColor ??
              context.themeColors.primaryColor.withValues(alpha: 0.05),
          highlightColor:
              splashColor ??
              context.themeColors.primaryColor.withValues(alpha: 0.05),
          splashFactory: InkSplash.splashFactory,
          child: Container(
            padding: padding,
            alignment: alignment,
            constraints: constraints,
            width: width,
            height: height,
            child: child,
          ),
        ),
      ),
    );
  }

  BorderRadiusGeometry? _borderRadiusGeometry() {
    switch (shape) {
      case CardContainerShape.rounded:
        return BorderRadius.circular(borderRadius);
      default:
        return null;
    }
  }

  ShapeBorder? _shapeBorder() {
    switch (shape) {
      case CardContainerShape.circle:
        return const CircleBorder();
      default:
        return null;
    }
  }

  BoxDecoration? _boxDecoration(BuildContext context) {
    if (isTransparent) return null;
    final isDarkmode = context.theme.brightness == Brightness.dark;

    final shadowColor =
        isDarkmode
            ? Colors.black.withValues(alpha: 0.5)
            : Colors.black.withValues(alpha: 0.05);

    final shadow =
        withShadow
            ? [
              BoxShadow(
                color: shadowColor,
                blurRadius: isDarkmode ? 6 : 12,
                offset: Offset(0, isDarkmode ? 2 : 4),
                spreadRadius: 0,
              ),
            ]
            : null;

    return switch (shape) {
      CardContainerShape.rounded => BoxDecoration(
        color: color,
        boxShadow: shadow,
        border:
            border ?? Border.all(width: 0.5, color: context.themeColors.border),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      _ => null,
    };
  }
}

enum CardContainerShape { rounded, circle }
