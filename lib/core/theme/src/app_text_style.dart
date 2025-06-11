part of '../theme.dart';

@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle label;
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle body;
  final TextStyle footnote;
  final TextStyle largeTitle;
  final TextStyle appbarTitle;

  const AppTextStyles({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.footnote,
    required this.largeTitle,
    required this.appbarTitle,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? label,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? body,
    TextStyle? footnote,
    TextStyle? largeTitle,
    TextStyle? appbarTitle,
  }) {
    return AppTextStyles(
      label: label ?? this.label,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      body: body ?? this.body,
      footnote: footnote ?? this.footnote,
      largeTitle: largeTitle ?? this.largeTitle,
      appbarTitle: appbarTitle ?? this.appbarTitle,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;

    return AppTextStyles(
      label: TextStyle.lerp(label, other.label, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      footnote: TextStyle.lerp(footnote, other.footnote, t)!,
      largeTitle: TextStyle.lerp(largeTitle, other.largeTitle, t)!,
      appbarTitle: TextStyle.lerp(appbarTitle, other.appbarTitle, t)!,
    );
  }

  // === LIGHT THEME ===
  static const AppTextStyles light = AppTextStyles(
    label: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryLight,
    ),
    title: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    subtitle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textHintLight,
    ),
    body: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
    ),
    footnote: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textHintLight,
    ),
    largeTitle: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    appbarTitle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
  );

  // === DARK THEME ===
  static const AppTextStyles dark = AppTextStyles(
    label: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryDark,
    ),
    title: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    subtitle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textHintDark,
    ),
    body: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
    ),
    footnote: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textHintDark,
    ),
    largeTitle: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    appbarTitle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
  );
}
