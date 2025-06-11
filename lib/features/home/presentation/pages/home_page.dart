import 'package:carousel_slider/carousel_slider.dart';
import 'package:chili_disease_detection/core/tensorflow/tensorflow.dart';
import 'package:chili_disease_detection/shared/misc/formatters.dart';
import 'package:chili_disease_detection/shared/widgets/card/card_container.dart';
import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  final List<CardItemModel> itemList =
      ClassesResult.values.map((e) {
        return CardItemModel(
          ciri: Formatters.getCiriCiri(e),
          dampak: Formatters.getDampak(e),
          penanganan: Formatters.getPenanganan(e),
          penyebabUmum: Formatters.getPenyebabUmum(e),
          imagePath: Formatters.getImagePath(e),
          item: e,
        );
      }).toList();

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Scrollbar(
          controller: _scrollController,
          child: ListView(
            children: [
              Padding(
                padding: AppPadding.horizontal,
                child: Text(
                  "Let's Check Your\nChili Plants!!",
                  style: context.textStyle.largeTitle,
                ),
              ),
              const SizedBox(height: 60),
              CarouselSlider(
                options: CarouselOptions(
                  height: 650,
                  autoPlay: true,
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                ),
                items: generateSliderList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateSliderList(BuildContext context) {
    return itemList.map((item) {
      int sectionIndex = 1;

      return GestureDetector(
        child: ClipRRect(
          borderRadius: AppBorderRadius.medium,
          child: CardContainer(
            width: context.fullWidth,
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                Image.asset(
                  item.imagePath,
                  fit: BoxFit.fill,
                  height: context.fullHeight * 0.3,
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                Text(
                  Formatters.formatSelectedResultName(item.item),
                  style: context.textStyle.appbarTitle,
                ),
                Text(
                  "(${Formatters.formatSelectedResulTranslateName(item.item)})",
                  style: context.textStyle.title,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    padding: AppPadding.horizontal,
                    children: [
                      if (item.ciri.isNotEmpty) ...[
                        Text(
                          "${sectionIndex++}. Ciri-Ciri",
                          style: context.textStyle.title,
                        ),
                        const SizedBox(height: 8),
                        Text(item.ciri, textAlign: TextAlign.justify),
                      ],
                      if (item.dampak.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        Text(
                          "${sectionIndex++}. Gejala",
                          style: context.textStyle.title,
                        ),
                        const SizedBox(height: 8),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: item.dampak.length,
                          itemBuilder: (context, index) {
                            String letter =
                                "${String.fromCharCode(65 + index).toLowerCase()}.";
                            return ListTile(
                              dense: true,
                              minLeadingWidth: 4,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              leading: Text(
                                letter,
                                style: context.textStyle.body,
                              ),
                              titleAlignment: ListTileTitleAlignment.top,
                              title: Text(
                                item.dampak[index],
                                style: context.textStyle.body,
                              ),
                            );
                          },
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 2.0),
                        ),
                      ],
                      if (item.penyebabUmum.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        Text(
                          "${sectionIndex++}. Penyebab Umum",
                          style: context.textStyle.title,
                        ),
                        const SizedBox(height: 8),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: item.penyebabUmum.length,
                          itemBuilder: (context, index) {
                            String letter =
                                "${String.fromCharCode(65 + index).toLowerCase()}.";
                            return ListTile(
                              dense: true,
                              minLeadingWidth: 4,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              leading: Text(
                                letter,
                                style: context.textStyle.body,
                              ),
                              titleAlignment: ListTileTitleAlignment.top,
                              title: Text(
                                item.penyebabUmum[index],
                                style: context.textStyle.body,
                              ),
                            );
                          },
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 2.0),
                        ),
                      ],
                      if (item.penanganan.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        Text(
                          "${sectionIndex++}. Penanganan",
                          style: context.textStyle.title,
                        ),
                        const SizedBox(height: 8),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: item.penanganan.length,
                          itemBuilder: (context, index) {
                            String letter =
                                "${String.fromCharCode(65 + index).toLowerCase()}.";
                            return ListTile(
                              dense: true,
                              minLeadingWidth: 4,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              leading: Text(
                                letter,
                                style: context.textStyle.body,
                              ),
                              titleAlignment: ListTileTitleAlignment.top,
                              title: Text(
                                item.penanganan[index],
                                style: context.textStyle.body,
                              ),
                            );
                          },
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 2.0),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}

class CardItemModel {
  final String imagePath;
  final String ciri;
  final List<String> dampak;
  final List<String> penyebabUmum;
  final List<String> penanganan;
  final ClassesResult item;
  CardItemModel({
    required this.imagePath,
    required this.item,
    required this.ciri,
    required this.dampak,
    required this.penyebabUmum,
    required this.penanganan,
  });
}
