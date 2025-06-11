part of '../theme.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color appContainerBackground;
  final Color appContainerShadow;
  final Color selectedLabel;
  final Color unselectedLabel;
  final Color primaryColor;
  final Color whiteColor;
  final Color blackColor;
  final Color fontColor;
  final Color hintColor;
  final Color dialogColor;
  final Color separatorColor;
  final Color border;
  final Color success;
  final Color failed;
  final Color warning;

  const AppThemeColors({
    required this.appContainerBackground,
    required this.appContainerShadow,
    required this.selectedLabel,
    required this.unselectedLabel,
    required this.primaryColor,
    required this.fontColor,
    required this.hintColor,
    required this.dialogColor,
    required this.separatorColor,
    required this.border,
    required this.success,
    required this.failed,
    required this.warning,
    required this.whiteColor,
    required this.blackColor,
  });

  @override
  ThemeExtension<AppThemeColors> copyWith({
    Color? appTitleBar,
    Color? appContainerBackground,
    Color? appContainerShadow,
    Color? selectedLabel,
    Color? unselectedLabel,
    Color? primaryColor,
    Color? fontColor,
    Color? hintColor,
    Color? dialogColor,
    Color? border,
    Color? success,
    Color? failed,
    Color? warning,
    Color? separatorColor,
    Color? whiteColor,
    Color? blackColor,
  }) {
    return AppThemeColors(
      appContainerBackground:
          appContainerBackground ?? this.appContainerBackground,
      appContainerShadow: appContainerShadow ?? this.appContainerShadow,
      selectedLabel: selectedLabel ?? this.selectedLabel,
      unselectedLabel: unselectedLabel ?? this.unselectedLabel,
      primaryColor: primaryColor ?? this.primaryColor,
      fontColor: fontColor ?? this.fontColor,
      hintColor: hintColor ?? this.hintColor,
      border: border ?? this.border,
      success: success ?? this.success,
      failed: failed ?? this.failed,
      warning: warning ?? this.warning,
      dialogColor: dialogColor ?? this.dialogColor,
      separatorColor: separatorColor ?? this.separatorColor,
      whiteColor: whiteColor ?? this.whiteColor,
      blackColor: blackColor ?? this.blackColor,
    );
  }

  @override
  ThemeExtension<AppThemeColors> lerp(
    ThemeExtension<AppThemeColors>? other,
    double t,
  ) {
    if (other is! AppThemeColors) {
      return this;
    }

    return AppThemeColors(
      appContainerBackground:
          Color.lerp(appContainerBackground, other.appContainerBackground, t)!,

      appContainerShadow:
          Color.lerp(appContainerShadow, other.appContainerShadow, t)!,
      selectedLabel: Color.lerp(selectedLabel, other.selectedLabel, t)!,
      unselectedLabel: Color.lerp(unselectedLabel, other.unselectedLabel, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      fontColor: Color.lerp(fontColor, other.fontColor, t)!,
      hintColor: Color.lerp(hintColor, other.hintColor, t)!,
      border: Color.lerp(border, other.border, t)!,
      success: Color.lerp(success, other.success, t)!,
      failed: Color.lerp(failed, other.failed, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      dialogColor: Color.lerp(dialogColor, other.dialogColor, t)!,
      separatorColor: Color.lerp(separatorColor, other.separatorColor, t)!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      blackColor: Color.lerp(blackColor, other.blackColor, t)!,
    );
  }

  // Light Theme Colors
  static AppThemeColors get light => const AppThemeColors(
    appContainerBackground: AppColors.backgroundLight,
    appContainerShadow: AppColors.containerShadowLight,
    selectedLabel: AppColors.selectedLabelLight,
    unselectedLabel: AppColors.unselectedLabelLight,
    primaryColor: AppColors.primary,
    fontColor: AppColors.black,
    hintColor: AppColors.textHintLight,
    dialogColor: AppColors.dialogBackgroundLight,
    separatorColor: AppColors.separatorLight,
    border: AppColors.borderDefaultLight,
    success: AppColors.success,
    failed: AppColors.failed,
    warning: AppColors.warning,
    whiteColor: AppColors.white,
    blackColor: AppColors.black,
  );

  // Dark Theme Colors
  static AppThemeColors get dark => const AppThemeColors(
    appContainerBackground: AppColors.backgroundDarkSecondary,
    appContainerShadow: AppColors.containerShadowDark,
    selectedLabel: AppColors.selectedLabelDark,
    unselectedLabel: AppColors.unselectedLabelDark,
    primaryColor: AppColors.primary,
    fontColor: AppColors.white,
    hintColor: AppColors.textHintDark,
    dialogColor: AppColors.dialogBackgroundDark,
    separatorColor: AppColors.separatorDark,
    border: AppColors.borderDefaultDark,
    success: AppColors.success,
    failed: AppColors.failed,
    warning: AppColors.warning,
    whiteColor: AppColors.white,
    blackColor: AppColors.black,
  );
}
