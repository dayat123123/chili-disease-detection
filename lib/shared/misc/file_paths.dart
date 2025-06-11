class FilePaths {
  const FilePaths._();
  static const String _rootPath = "assets";
  static const String _imagesPath = "$_rootPath/images";
  static const String _tensorflowPath = "$_rootPath/tensorflow";

  static const String splash = "$_imagesPath/logo-app.png";
  static const String l1 = "$_imagesPath/l1.jpeg";
  static const String l2 = "$_imagesPath/l2.jpeg";
  static const String l3 = "$_imagesPath/l3.jpeg";
  static const String l4 = "$_imagesPath/l4.jpeg";

  static const String healthy = "$_imagesPath/healthy.jpg";
  static const String spot = "$_imagesPath/spot.jpg";
  static const String yellow = "$_imagesPath/yellow.jpg";
  static const String curly = "$_imagesPath/curly.jpg";

  static const String modelTFLite =
      "$_tensorflowPath/model_cabai_20250528.tflite";
}
