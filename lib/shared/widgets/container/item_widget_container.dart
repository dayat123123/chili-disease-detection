import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';
import 'package:chili_disease_detection/shared/widgets/card/card_container.dart';
import 'package:chili_disease_detection/shared/widgets/container/unsplash_widget.dart';

class ContainerWithSubItem extends StatelessWidget {
  final List<ItemWidgetContainer> listWidget;
  final String title;
  final bool withTitle;
  final bool withBorder;
  const ContainerWithSubItem({
    super.key,
    required this.listWidget,
    this.title = "",
    this.withTitle = true,
    this.withBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyle.title;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withTitle) Text(title, style: textStyle),
        const SizedBox(height: 15),
        CardContainer(
          padding: EdgeInsets.zero,
          withBottomMargin: false,
          width: context.fullWidth,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder:
                (context, index) => _itemWidget(listWidget[index], context),
            separatorBuilder:
                (context, index) =>
                    Padding(padding: AppPadding.horizontal, child: Divider()),
            itemCount: listWidget.length,
          ),
        ),
      ],
    );
  }

  Widget _itemWidget(ItemWidgetContainer data, BuildContext context) {
    return UnsplashWidget(
      child: ListTile(
        dense: true,
        minTileHeight: data.tileHeight,
        contentPadding: AppPadding.horizontal,
        trailing: data.trailing,
        leading: data.icon,
        isThreeLine: data.subtitle.isNotEmpty,
        title: Text(
          data.title,
          style:
              data.titleTextStyle ??
              context.textStyle.title.copyWith(fontSize: 14),
        ),
        subtitle:
            data.subtitle.isEmpty
                ? null
                : Text(
                  data.subtitle,
                  style:
                      data.subtitleTextStyle ??
                      context.textStyle.subtitle.copyWith(fontSize: 11),
                ),
        onTap: data.onTap,
      ),
    );
  }
}

class GroupedContainerWithSubItem extends StatelessWidget {
  final Map<String, List<ItemWidgetContainer>> groupedData;

  const GroupedContainerWithSubItem({super.key, required this.groupedData});

  @override
  Widget build(BuildContext context) {
    final sortedKeys =
        groupedData.keys.toList()..sort((a, b) => b.compareTo(a));

    return Column(
      children:
          sortedKeys.map((dateKey) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ContainerWithSubItem(
                withTitle: true,
                title: dateKey,
                listWidget: groupedData[dateKey]!,
              ),
            );
          }).toList(),
    );
  }
}

class ItemWidgetContainer {
  final String title;
  final String subtitle;
  final Widget? icon;
  final Widget? trailing;
  final double? tileHeight;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final VoidCallback? onTap;

  ItemWidgetContainer({
    required this.title,
    this.subtitle = '',
    this.icon,
    this.onTap,
    this.trailing,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.tileHeight,
  });
}
