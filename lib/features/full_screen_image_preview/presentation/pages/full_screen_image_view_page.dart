import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewPage extends StatelessWidget {
  final File imageFile;

  const FullScreenImageViewPage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Gambar"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PhotoView(
        imageProvider: FileImage(imageFile),
        backgroundDecoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
