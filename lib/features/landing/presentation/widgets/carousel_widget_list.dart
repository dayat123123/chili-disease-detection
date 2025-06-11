import 'package:flutter/material.dart';
import 'package:chili_disease_detection/shared/misc/file_paths.dart';

class CarouselWidgetList {
  static List<Widget> listWidget = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.l1),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.l2),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.l3),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(FilePaths.l4),
        ),
      ),
    ),
  ];
}
