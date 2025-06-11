import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';

class _CarouselController extends ChangeNotifier {
  int _currentIndex;

  _CarouselController({required int initialIndex})
    : _currentIndex = initialIndex;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}

class CustomCarousel extends StatefulWidget {
  final List<Widget> listwidget;
  final void Function(TabController)? onInitialized;
  final double? positionedIndicatorBottom;
  final double? positionedIndicatorTop;
  final double? positionedIndicatorLeft;
  final double? positionedIndicatorRight;
  final bool animateView;
  final bool isShowIndicator;
  final int durationAnimateinseconds;
  final bool withPadding;
  final int initialIndex;

  const CustomCarousel({
    super.key,
    required this.listwidget,
    this.positionedIndicatorBottom,
    this.animateView = false,
    this.isShowIndicator = true,
    this.durationAnimateinseconds = 8,
    this.withPadding = false,
    this.initialIndex = 0,
    this.positionedIndicatorTop,
    this.positionedIndicatorLeft,
    this.positionedIndicatorRight,
    this.onInitialized,
  });

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final _CarouselController _carouselController;
  late final List<Widget> _listCarouselwidget;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _carouselController = _CarouselController(
      initialIndex: widget.initialIndex,
    );
    _listCarouselwidget = widget.listwidget;
    _tabController = TabController(
      length: _listCarouselwidget.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _tabController.addListener(() {
      _carouselController.currentIndex = _tabController.index;
    });

    _startAutoAnimate();
    _onInitialized();
  }

  void _onInitialized() {
    widget.onInitialized?.call(_tabController);
  }

  void _startAutoAnimate() {
    if (widget.animateView) {
      _timer = Timer.periodic(
        Duration(seconds: widget.durationAnimateinseconds),
        (timer) {
          int nextIndex = _carouselController.currentIndex + 1;
          if (nextIndex >= _listCarouselwidget.length) {
            nextIndex = 0;
          }
          _carouselController.currentIndex = nextIndex;
          _tabController.animateTo(
            nextIndex,
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 500),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer?.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        TabBarView(
          clipBehavior: Clip.antiAlias,
          controller: _tabController,
          children: List.generate(
            _listCarouselwidget.length,
            (index) =>
                widget.withPadding
                    ? Padding(
                      padding: AppPadding.horizontal,
                      child: _listCarouselwidget[index],
                    )
                    : _listCarouselwidget[index],
          ),
        ),
        if (widget.isShowIndicator)
          Positioned(
            top: widget.positionedIndicatorTop,
            left: widget.positionedIndicatorLeft,
            right: widget.positionedIndicatorRight,
            bottom: widget.positionedIndicatorBottom,
            child: AnimatedBuilder(
              animation: _carouselController,
              builder:
                  (context, _) => _PageIndicator(
                    inactiveColor: context.themeColors.unselectedLabel,
                    activeColor: context.themeColors.primaryColor,
                    currentIndex: _carouselController.currentIndex,
                    itemCount: _listCarouselwidget.length,
                  ),
            ),
          ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final double dotSize = 8.0;
  final double dotSpacing = 8.0;
  final Color activeColor;
  final Color inactiveColor;

  const _PageIndicator({
    required this.currentIndex,
    required this.itemCount,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final isCurrent = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: dotSpacing / 2),
          width: isCurrent ? dotSize + 20 : dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
            color: isCurrent ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}
