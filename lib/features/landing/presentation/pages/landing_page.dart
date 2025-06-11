import 'package:chili_disease_detection/core/permissions_handler/permissions_handler.dart';
import 'package:flutter/material.dart';
import 'package:chili_disease_detection/core/router/route_path.dart';
import 'package:chili_disease_detection/core/theme/theme.dart';
import 'package:chili_disease_detection/features/landing/presentation/widgets/carousel_widget_list.dart';
import 'package:chili_disease_detection/injector.dart';
import 'package:chili_disease_detection/shared/extensions/context_extension.dart';
import 'package:chili_disease_detection/shared/widgets/card/card_container.dart';
import 'package:chili_disease_detection/shared/widgets/caruosel/custom_carousel.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> _listScreen = CarouselWidgetList.listWidget;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 250));
      await PermissionsHandler.requestCameraAndStoragePermission();
    });
    super.initState();
  }

  void _onTapGetStarted() {
    getRouter.go(RoutePath.homePath);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomCarousel(
            animateView: true,
            durationAnimateinseconds: 10,
            listwidget: _listScreen,
            positionedIndicatorTop: 75,
            positionedIndicatorRight: 30,
          ),
          Positioned(
            top: context.fullHeight * 0.225,
            left: 0,
            right: 0,
            child: Padding(
              padding: AppPadding.horizontal,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Welcome!",
                  textAlign: TextAlign.center,
                  style: context.textStyle.largeTitle.copyWith(
                    color: context.themeColors.whiteColor,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: context.fullHeight * 0.1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  _bottomButtonWidget(
                    'Mulai',
                    _onTapGetStarted,
                    context.themeColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButtonWidget(
    String label,
    VoidCallback onTap,
    Color buttonColor,
  ) {
    return CardContainer(
      height: 60,
      width: context.fullWidth * 0.8,
      color: buttonColor,
      onTap: onTap,
      child: Text(label, style: context.textStyle.title),
    );
  }
}
