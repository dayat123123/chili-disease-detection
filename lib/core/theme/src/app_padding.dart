part of '../theme.dart';

@immutable
abstract class AppPadding {
  // Padding umum
  static const EdgeInsets all = EdgeInsets.all(16.0);

  // Padding untuk hanya sisi horizontal
  static const EdgeInsets horizontal = EdgeInsets.symmetric(horizontal: 16.0);

  // Padding untuk hanya sisi vertikal
  static const EdgeInsets vertical = EdgeInsets.symmetric(vertical: 16.0);

  // Padding khusus untuk margin di sekitar widget
  static const EdgeInsets around = EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0);

  // Padding kecil untuk icon atau komponen kecil lainnya
  static const EdgeInsets small = EdgeInsets.all(8.0);

  // Padding untuk header atau bagian atas
  static const EdgeInsets top = EdgeInsets.only(top: 24.0);

  // Padding untuk footer atau bagian bawah
  static const EdgeInsets bottom = EdgeInsets.only(bottom: 24.0);

  // Padding khusus untuk ListView atau scrollable content
  static const EdgeInsets listView = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 8.0,
  );
}
