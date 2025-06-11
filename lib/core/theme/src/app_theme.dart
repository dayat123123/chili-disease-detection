part of '../theme.dart';

@immutable
abstract class AppTheme {
  static const String _fontFamily = "Poppins";

  static ThemeData lightTheme = ThemeData(
    fontFamily: _fontFamily,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.canvasColorLight,
    canvasColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      onSurface: AppColors.black,
    ),

    appBarTheme: AppBarTheme(
      elevation: 2,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.canvasColorLight,
      titleTextStyle: AppTextStyles.light.appbarTitle,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.backroundLightBottomNavbarbar,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      strokeWidth: 6,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.separatorLight),
    dividerColor: AppColors.separatorLight,
    extensions: <ThemeExtension<dynamic>>[
      AppThemeColors.light,
      AppTextStyles.light,
    ],
    textTheme: TextTheme(
      displayLarge: AppTextStyles.light.largeTitle,
      displayMedium: AppTextStyles.light.title,
      displaySmall: AppTextStyles.light.subtitle,
      headlineLarge: AppTextStyles.light.largeTitle,
      headlineMedium: AppTextStyles.light.title,
      headlineSmall: AppTextStyles.light.subtitle,
      titleLarge: AppTextStyles.light.largeTitle,
      titleMedium: AppTextStyles.light.title,
      titleSmall: AppTextStyles.light.subtitle,
      bodyLarge: AppTextStyles.light.body,
      bodyMedium: AppTextStyles.light.body,
      bodySmall: AppTextStyles.light.footnote,
      labelLarge: AppTextStyles.light.label,
      labelMedium: AppTextStyles.light.label,
      labelSmall: AppTextStyles.light.label,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.formFieldBackgroundLight,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderDefaultLight),
      ),
      labelStyle: AppTextStyles.light.label,
      hintStyle: const TextStyle(color: AppColors.textHintLight),
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.backgroundLight,
      surfaceTintColor: AppColors.backgroundLight,
      shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.large),
      titleTextStyle: AppTextStyles.light.title,
      contentTextStyle: AppTextStyles.light.body,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: _fontFamily,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    canvasColor: AppColors.backgroundDarkSecondary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      onSurface: AppColors.white,
    ),
    appBarTheme: AppBarTheme(
      elevation: 2,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.backgroundDark,
      titleTextStyle: AppTextStyles.dark.appbarTitle,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      strokeWidth: 6,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.separatorDark),
    dividerColor: AppColors.separatorDark,
    extensions: <ThemeExtension<dynamic>>[
      AppThemeColors.dark,
      AppTextStyles.dark,
    ],
    textTheme: TextTheme(
      displayLarge: AppTextStyles.dark.largeTitle,
      displayMedium: AppTextStyles.dark.title,
      displaySmall: AppTextStyles.dark.subtitle,
      headlineLarge: AppTextStyles.dark.largeTitle,
      headlineMedium: AppTextStyles.dark.title,
      headlineSmall: AppTextStyles.dark.subtitle,
      titleLarge: AppTextStyles.dark.largeTitle,
      titleMedium: AppTextStyles.dark.title,
      titleSmall: AppTextStyles.dark.subtitle,
      bodyLarge: AppTextStyles.dark.body,
      bodyMedium: AppTextStyles.dark.body,
      bodySmall: AppTextStyles.dark.footnote,
      labelLarge: AppTextStyles.dark.label,
      labelMedium: AppTextStyles.dark.label,
      labelSmall: AppTextStyles.dark.label,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.formFieldBackgroundDark,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderDefaultDark),
      ),
      labelStyle: AppTextStyles.dark.label,
      hintStyle: const TextStyle(color: AppColors.textHintDark),
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.backgroundDarkSecondary,
      surfaceTintColor: AppColors.backgroundDarkSecondary,
      shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.large),
      titleTextStyle: AppTextStyles.dark.title,
      contentTextStyle: AppTextStyles.dark.body,
    ),
  );
}
