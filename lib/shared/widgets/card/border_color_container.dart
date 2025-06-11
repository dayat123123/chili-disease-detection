import 'package:chili_disease_detection/shared/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';

class BorderColorContainer extends StatelessWidget {
  final Color? color;
  final String? title;
  final double? titleSize;
  final Widget? customChild;
  const BorderColorContainer({
    super.key,
    this.color,
    this.customChild,
    this.title,
    this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color ?? context.themeColors.primaryColor),
        borderRadius: BorderRadius.circular(2),
      ),
      child:
          customChild ??
          Text(
            title ?? "Title",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color ?? context.themeColors.primaryColor,
              fontSize: titleSize ?? 11,
            ),
          ),
    );
  }
}
