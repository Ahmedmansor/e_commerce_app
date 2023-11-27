import 'package:e_commerce_app/on%20Boarding/presentation/widgets/custom_page_view.dart';
import 'package:e_commerce_app/utils/app_setting.dart';
import 'package:e_commerce_app/utils/navigation_util.dart';
import 'package:e_commerce_app/widgets/custom_buttoms.dart';
import 'package:flutter/material.dart';

import '../../../layout/layout_screen.dart';
import '../../../repos/const.dart';
import '../../../screens/auth/presentation/login/login_screen.dart';
import 'custom_indicator.dart';

// ignore: must_be_immutable
class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({
    super.key,
  });

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageView(pageController: pageController!),
        Positioned(
          left: 0,
          right: 0,
          bottom: AppSettings.defultSize * 25,
          child: Center(
            child: CustomIndicator(
              dotIndex: pageController!.hasClients ? pageController?.page : 0,
            ),
          ),
        ),
        Visibility(
          visible: pageController!.hasClients
              ? (pageController?.page == 2 ? false : true)
              : true,
          child: Positioned(
            top: AppSettings.defultSize * 10,
            right: AppSettings.defultSize * 2,
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff898989),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: AppSettings.defultSize * 10,
          left: AppSettings.defultSize * 10,
          right: AppSettings.defultSize * 10,
          child: CustomGeneralButton(
            text: pageController!.hasClients
                ? (pageController?.page == 2 ? 'Get started' : 'Next')
                : 'Next',
            onTap: () {
              if (pageController!.page! < 2) {
                pageController?.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              } else {
                NavigationUtils.goTo(
                    context,
                    token != null && token != ""
                        ? const LayoutScreen()
                        : LoginScreen());
              }
            },
          ),
        ),
      ],
    );
  }
}
