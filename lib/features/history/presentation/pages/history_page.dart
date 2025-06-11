import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chili_disease_detection/core/router/route_path.dart';
import 'package:chili_disease_detection/core/tensorflow/tensorflow.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/features/history/presentation/bloc/history_bloc.dart';
import 'package:chili_disease_detection/injector.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';
import 'package:chili_disease_detection/shared/misc/formatters.dart';
import 'package:chili_disease_detection/shared/widgets/container/item_widget_container.dart';
import 'package:chili_disease_detection/shared/widgets/loading_indicator/loading_indicator_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoryBloc _historyBloc;
  late final ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _historyBloc = getHistoryBloc..add(LoadHistoryData());
    super.initState();
  }

  void _onTapClearHistories() {
    context.showAlertDialog(
      title: "Perhatian!",

      content: "Apakah kamu yakin ingin menghapus?",
      onPressed: () {
        _historyBloc.add(ClearHistories());
      },
    );
  }

  void _onTapItem(ResultClassModel data) {
    getRouter.push(RoutePath.analyzedPath, extra: data);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        actions: [
          TextButton(
            onPressed: _onTapClearHistories,
            child: Text(
              "Hapus history",
              style: context.textStyle.title.copyWith(
                color: context.themeColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        bloc: _historyBloc,
        builder: (context, state) {
          if (state is HistoryLoading) {
            return Center(child: LoadingIndicatorWidget(scale: 1.5));
          } else if (state is HistoryLoaded) {
            final Map<String, List<ItemWidgetContainer>> groupedItems = {};
            for (final item in state.listData) {
              final dateKey = Formatters.formatDateOnly(item.lastUpdated);
              groupedItems
                  .putIfAbsent(dateKey, () => [])
                  .add(
                    ItemWidgetContainer(
                      onTap: () => _onTapItem(item),
                      tileHeight: 50,
                      title: Formatters.formatSelectedResultName(item.selected),
                      subtitle:
                          "Akurasi: ${Formatters.formatAccuracy(item.accuracy)}",
                      trailing: Text(
                        Formatters.formatTimeOnly(item.lastUpdated),
                      ),
                      icon: CircleAvatar(
                        radius: 18,
                        backgroundImage: FileImage(item.imageFile),
                      ),
                    ),
                  );
            }
            return Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                padding: AppPadding.horizontal,
                controller: _scrollController,
                child: GroupedContainerWithSubItem(groupedData: groupedItems),
              ),
            );
          } else if (state is HistoryError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
