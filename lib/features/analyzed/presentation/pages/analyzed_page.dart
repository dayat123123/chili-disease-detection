import 'dart:io';
import 'package:chili_disease_detection/shared/misc/formatters.dart';
import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/router/route_path.dart';
import 'package:chili_disease_detection/core/tensorflow/tensorflow.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/injector.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';

class AnalyzedPage extends StatefulWidget {
  final ResultClassModel result;
  const AnalyzedPage({super.key, required this.result});

  @override
  State<AnalyzedPage> createState() => _AnalyzedPageState();
}

class _AnalyzedPageState extends State<AnalyzedPage> {
  void _onTapPreview(File file) {
    getRouter.push(RoutePath.fullScreenImageViewPath, extra: file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Formatters.formatSelectedResultName(widget.result.selected),
            style: context.textStyle.appbarTitle,
          ),
          Text(
            "(${Formatters.formatSelectedResulTranslateName(widget.result.selected)})",
            style: context.textStyle.appbarTitle,
          ),
          SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              _onTapPreview(widget.result.imageFile);
            },
            child: Container(
              height: context.fullHeight * 0.3,
              width: context.fullWidth * 0.8,
              decoration: BoxDecoration(
                borderRadius: AppBorderRadius.medium,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(widget.result.imageFile),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          if (widget.result.accuracy > 0)
            Text(
              "Akurasi ${Formatters.formatAccuracy(widget.result.accuracy)}",
              style: context.textStyle.title,
            ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              width: context.fullWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: context.themeColors.appContainerShadow,
                    offset: Offset(2, -2),
                  ),
                ],
                color: context.themeColors.appContainerBackground,
              ),
              padding: EdgeInsets.only(top: 10, left: 16, right: 16),
              child: _buildContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final ciri = Formatters.getCiriCiri(widget.result.selected);
    final gejala = Formatters.getDampak(widget.result.selected);
    final penyebabUmum = Formatters.getPenyebabUmum(widget.result.selected);
    final penanganan = Formatters.getPenanganan(widget.result.selected);

    int sectionIndex = 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text("Deskripsi", style: context.textStyle.title)),
        SizedBox(height: 4),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              if (ciri.isNotEmpty) ...[
                SizedBox(height: 15),
                Text(
                  "${sectionIndex++}. Ciri-Ciri",
                  style: context.textStyle.title,
                ),
                SizedBox(height: 8),
                Text(ciri, textAlign: TextAlign.justify),
              ],
              if (gejala.isNotEmpty) ...[
                SizedBox(height: 15),
                Text(
                  "${sectionIndex++}. Gejala",
                  style: context.textStyle.title,
                ),
                SizedBox(height: 8),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: gejala.length,
                  itemBuilder: (context, index) {
                    String letter =
                        "${String.fromCharCode(65 + index).toLowerCase()}.";
                    return ListTile(
                      dense: true,
                      minLeadingWidth: 4,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: Text(letter, style: context.textStyle.body),
                      titleAlignment: ListTileTitleAlignment.top,
                      title: Text(gejala[index], style: context.textStyle.body),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 2.0),
                ),
              ],
              if (penyebabUmum.isNotEmpty) ...[
                SizedBox(height: 15),
                Text(
                  "${sectionIndex++}. Penyebab Umum",
                  style: context.textStyle.title,
                ),
                SizedBox(height: 8),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: penyebabUmum.length,
                  itemBuilder: (context, index) {
                    String letter =
                        "${String.fromCharCode(65 + index).toLowerCase()}.";
                    return ListTile(
                      dense: true,
                      minLeadingWidth: 4,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: Text(letter, style: context.textStyle.body),
                      titleAlignment: ListTileTitleAlignment.top,
                      title: Text(
                        penyebabUmum[index],
                        style: context.textStyle.body,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 2.0),
                ),
              ],
              if (penanganan.isNotEmpty) ...[
                SizedBox(height: 15),
                Text(
                  "${sectionIndex++}. Penanganan",
                  style: context.textStyle.title,
                ),
                SizedBox(height: 8),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: penanganan.length,
                  itemBuilder: (context, index) {
                    String letter =
                        "${String.fromCharCode(65 + index).toLowerCase()}.";
                    return ListTile(
                      dense: true,
                      minLeadingWidth: 4,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: Text(letter, style: context.textStyle.body),
                      titleAlignment: ListTileTitleAlignment.top,
                      title: Text(
                        penanganan[index],
                        style: context.textStyle.body,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 2.0),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
