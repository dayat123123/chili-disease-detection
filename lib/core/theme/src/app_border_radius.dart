part of '../theme.dart';

@immutable
abstract class AppBorderRadius {
  // Untuk elemen kecil
  static const double smallNumber = 4.0;
  static const double mediumNumber = 8.0;
  static const double largeNumber = 16.0;
  static const double extraLargeNumber = 24.0;
  static const double inputFieldNumber = 12.0;
  static const double buttonNumber = 30.0;

  static const BorderRadius small = BorderRadius.all(
    Radius.circular(smallNumber),
  );
  // Untuk elemen medium
  static const BorderRadius medium = BorderRadius.all(
    Radius.circular(mediumNumber),
  );
  // Untuk elemen besar
  static const BorderRadius large = BorderRadius.all(
    Radius.circular(largeNumber),
  );

  // Border radius untuk Card atau Container yang lebih besar
  static const BorderRadius extraLarge = BorderRadius.all(
    Radius.circular(extraLargeNumber),
  );

  // Border radius untuk InputField yang lebih halus
  static const BorderRadius inputField = BorderRadius.all(
    Radius.circular(inputFieldNumber),
  );

  // Border radius khusus untuk tombol (FloatingActionButton, Button, dll.)
  static const BorderRadius button = BorderRadius.all(
    Radius.circular(buttonNumber),
  );
}
