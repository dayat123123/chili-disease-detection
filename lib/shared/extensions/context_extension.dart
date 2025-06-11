import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/injector.dart';
import 'package:chili_disease_detection/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:chili_disease_detection/shared/widgets/loading_indicator/loading_indicator_widget.dart';

part '../widgets/dialog_and_notification/dialog_and_notification.dart';
part 'string_extension.dart';

extension ContextExtension on BuildContext {
  void showToast({
    Color? color,
    String title = "",
    String subtitle = "",
    required BuildContext context,
    Duration duration = const Duration(seconds: 2),
    ToastStatus status = ToastStatus.info,
    ToastPosition position = ToastPosition.top,
  }) {
    DialogAndNotification.showToast(
      context: context,
      title: title,
      subtitle: subtitle,
      color: color,
      dialogAccentStatus: status,
      duration: duration,
      position: position,
    );
  }

  void showLoadingDialog({bool isDismissible = true}) {
    showDialog(
      context: this,
      barrierDismissible: isDismissible,
      builder:
          (_) => Center(
            child: Container(
              width: 120,
              height: 120,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: themeColors.appContainerBackground,
                borderRadius: AppBorderRadius.large,
              ),
              child: LoadingIndicatorWidget(scale: Platform.isIOS ? 1.5 : 1),
            ),
          ),
    );
  }

  void showAlertDialog({
    String? title,
    String? content,
    String? aproveNameButton,
    bool alowDismiss = true,
    void Function()? onPressed,
    void Function()? customOnpressed,
  }) {
    DialogAndNotification.showAlertDialog(
      context: this,
      alowDismiss: alowDismiss,
      content: content,
      onPressed: onPressed,
      title: title,
      customOnPressed: customOnpressed,
      aproveNameButton: aproveNameButton,
    );
  }

  void showBottomSheet({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    double? initialChildSize,
    double? maxChildSize,
    double? minChildSize,
    final Widget? header,
  }) async {
    showModalBottomSheet(
      context: this,
      showDragHandle: true,
      elevation: 0,
      useRootNavigator: true,
      isDismissible: isDismissible,
      sheetAnimationStyle: AnimationStyle().copyWith(
        reverseDuration: const Duration(milliseconds: 250),
      ),
      isScrollControlled: isScrollControlled,
      backgroundColor: themeColors.appContainerBackground,
      builder:
          (BuildContext context) => BottomSheetWidget(
            initialChildSize: initialChildSize,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            header:
                header == null
                    ? null
                    : Container(
                      padding: AppPadding.horizontal.copyWith(bottom: 5),
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: context.themeColors.border,
                            width: 0.5,
                          ),
                        ),
                        color: context.themeColors.appContainerBackground,
                      ),
                      child: header,
                    ),
            child: child,
          ),
    );
  }

  /// A shortcut to retrieve the [AppLocalizations] instance from the context.
  /// Used for translating text based on the app's locale.

  /// A shortcut to retrieve the current [ThemeData] from the context.
  /// Used for accessing theme properties such as colors, fonts, and more.
  ThemeData get theme => Theme.of(this);

  /// A shortcut to retrieve the custom [AppThemeColors] extension from the theme.
  /// Used to access custom-defined colors within the [AppThemeColors].
  AppThemeColors get themeColors => theme.extension<AppThemeColors>()!;

  /// A shortcut to retrieve the custom [AppTextStyles] extension from the theme.
  /// Used to access custom-defined text styles within the [AppTextStyles].
  AppTextStyles get textStyle => theme.extension<AppTextStyles>()!;

  /// A shortcut to retrieve the [TextTheme] from the theme.
  /// Used to access predefined text styles like headline, body, caption, etc.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// A shortcut to retrieve the [viewInsets] from the [MediaQuery].
  /// Represents areas of the screen that are fully obscured, such as by the keyboard.
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get fullHeight => mediaQuerySize.height;

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get fullWidth => mediaQuerySize.width;

  /// get the shortestSide from screen
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// True if the shortestSide is largest than 600p
  bool get isSmallTablet => (mediaQueryShortestSide >= 600);

  /// True if the shortestSide is largest than 720p
  bool get isLargeTablet => (mediaQueryShortestSide >= 720);

  /// True if the current device is Tablet
  bool get isTablet => isSmallTablet || isLargeTablet;

  /// True if the width is smaller than 1200p
  bool get isDesktopOrLess => fullWidth <= 1200;

  /// True if the width is higher than 1200p
  bool get isDesktopOrWider => fullWidth >= 1200;

  /// same as [isDesktopOrLess]
  bool get isDesktop => isDesktopOrLess;
}
