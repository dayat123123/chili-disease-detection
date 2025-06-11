import 'package:chili_disease_detection/core/tensorflow/tensorflow.dart';
import 'package:chili_disease_detection/shared/misc/formatters.dart';
import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/shared/widgets/container/item_widget_container.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late ScrollController _scrollController;

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
    return Scaffold(
      appBar: AppBar(title: Text("Info")),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: AppPadding.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerWithSubItem(
                  title: "Creator",
                  listWidget: [
                    ItemWidgetContainer(
                      title: "Nama",
                      subtitle: "Risma Asriati",
                    ),
                    ItemWidgetContainer(
                      title: "Universitas",
                      subtitle: "Universitas Islam Indragiri",
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ContainerWithSubItem(
                  title: "Overview Model",
                  listWidget: [
                    ItemWidgetContainer(
                      title: "Model",
                      subtitle: "Mobile Net V2",
                    ),
                    ItemWidgetContainer(
                      title: "Algoritma",
                      subtitle: "CNN (Convolutional Neural Network)",
                    ),
                    ItemWidgetContainer(
                      title: "Ukuran Input Gambar",
                      subtitle: "224 x 224",
                    ),
                    ItemWidgetContainer(
                      title: "Jumlah Class",
                      subtitle:
                          "4 Class (${ClassesResult.values.map((e) => Formatters.formatSelectedResultName(e))})",
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ContainerWithSubItem(
                  title: "Training Model",
                  listWidget: [
                    ItemWidgetContainer(
                      title: "Epochs",
                      subtitle:
                          "30 Epoch (training awal) + 30 Epoch (fine-tuning)",
                    ),
                    ItemWidgetContainer(
                      title: "Akurasi Training",
                      subtitle: "91.86 %",
                    ),
                    ItemWidgetContainer(
                      title: "Area under curve (AUC)",
                      subtitle: "0.9922",
                    ),
                    ItemWidgetContainer(
                      title: "Precision (avg)",
                      subtitle:
                          "Healthy: 0.98\nLeaf Curling: 0.92\nLeaf Spot: 0.90\nLeaf Yellowing: 0.89",
                    ),
                    ItemWidgetContainer(
                      title: "Recall (avg)",
                      subtitle:
                          "Healthy: 0.92\nLeaf Curling: 0.94\nLeaf Spot: 0.92\nLeaf Yellowing: 0.89",
                    ),
                    ItemWidgetContainer(
                      title: "F1-score (avg)",
                      subtitle:
                          "Healthy: 0.95\nLeaf Curling: 0.93\nLeaf Spot: 0.91\nLeaf Yellowing: 0.89",
                    ),
                  ],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
