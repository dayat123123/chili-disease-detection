part of '../theme.dart';

@immutable
abstract class AppColors {
  // === PRIMARY ===
  static const primary = Color(0xFF27C55D);

  // === COMMON ===
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const grey = Colors.grey;

  // === TEXT ===
  static const textPrimaryLight = Color(0xFF1C1C1E);
  static const textSecondaryLight = Color(0xFF3A3A3C);
  static const textHintLight = Color(0xFF8E8E93);

  static const textPrimaryDark = Color(0xFFF2F2F7);
  static const textSecondaryDark = Color(0xFFEBEBF5);
  static const textHintDark = Color(0xFFA0A0A5);

  // === FORM FIELD BACKGROUND ===
  static const formFieldBackgroundLight = Color(0xFFF2F2F7);
  static const formFieldBackgroundDark = Color(0xFF3A3B3C);

  // === BORDER ===
  static const borderDefaultLight = Color(0xFFD8D8D8);
  static const borderDefaultDark = Color(0xFF3A3A3C);

  // === BACKGROUND ===
  static const backgroundLight = Color(0xFFFFFFFF);
  static const canvasColorLight = Color(0xFFEBFFF2);

  static const backgroundLightSecondary = Color(0xFFF2F2F7);
  static const backroundLightBottomNavbarbar = Color(0xFFECF5E3);

  static const backgroundDark = Color(0xFF141414);
  static const backgroundDarkSecondary = Color(0xFF1C1C1E);

  // === STATUS COLORS ===
  static const success = Color(0xFF27C55D);
  static const info = Color(0xFF007AFF);
  static const warning = Color(0xFFFB8C00);
  static const failed = Color(0xFFD63434);

  // === CONTAINER SHADOW ===
  static const containerShadowLight = Color(0x1A000000);
  static const containerShadowDark = Color(0x66000000);

  // === LABEL COLORS ===
  static const selectedLabelLight = Color(0xFF1C1C1E);
  static const selectedLabelDark = Color(0xFFF2F2F7);
  static const unselectedLabelLight = Color(0xFF8E8E93);
  static const unselectedLabelDark = Color(0xFF636366);

  // === DIALOG COLORS ===
  static const dialogBackgroundLight = Color(0xFFF2F2F7);
  static const dialogBackgroundDark = Color(0xFF1C1C1E);

  // === SEPARATOR ===
  static const separatorLight = Color(0xFFC6C6C8);
  static const separatorDark = Color(0xFF3A3A3C);

  // === SNACKBAR ===
  static const snackbarBackgroundColor = Color(0xFF2C2C2E);
}
