import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../repos/colors.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key, required this.dotIndex});
  final num? dotIndex;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      decorator: DotsDecorator(
          color: Colors.transparent,
          activeColor: kMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: kMainColor),
          )),
      dotsCount: 3,
      position: dotIndex!.toInt(),
    );
  }
}
