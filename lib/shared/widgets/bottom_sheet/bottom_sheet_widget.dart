import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';

class BottomSheetWidget extends StatelessWidget {
  final Widget child;
  final Widget? header;
  final double? initialChildSize;
  final double? maxChildSize;
  final double? minChildSize;

  const BottomSheetWidget({
    super.key,
    required this.child,
    this.initialChildSize,
    this.maxChildSize,
    this.minChildSize,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize ?? 0.7,
      minChildSize: minChildSize ?? 0.25,
      maxChildSize: maxChildSize ?? 1,
      expand: false,
      builder: (context, controller) {
        return Container(
          alignment: Alignment.topCenter,
          width: context.fullWidth,
          decoration: BoxDecoration(
            color: context.themeColors.appContainerBackground,
            borderRadius: AppBorderRadius.large,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (header != null) header!,
              Expanded(
                child: RawScrollbar(
                  radius: Radius.circular(10),
                  thickness: 5,
                  thumbVisibility: false,
                  controller: controller,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
