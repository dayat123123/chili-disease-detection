part of '../theme.dart';

@immutable
class AppThemeModel {
  final String label;
  final ThemeData themeData;
  const AppThemeModel(this.label, this.themeData);
}

AppThemeModel get lightAppThemeModel =>
    AppThemeModel('light', AppTheme.lightTheme);
AppThemeModel get darkAppThemeModel =>
    AppThemeModel('dark', AppTheme.darkTheme);
