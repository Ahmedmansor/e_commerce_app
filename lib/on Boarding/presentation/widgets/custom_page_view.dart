import 'package:e_commerce_app/on%20Boarding/presentation/widgets/page_view_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomPageView extends StatelessWidget {
  CustomPageView({super.key, required this.pageController});

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        PageViewItem(
          image: 'images/Group 2804.png',
          title: 'E Shopping',
          subtitle: 'Explore  top organic fruits & grab them',
        ),
        PageViewItem(
            image: 'images/Group 2805.png',
            title: 'Delivery on the way',
            subtitle: 'Get your order by speed delivery'),
        PageViewItem(
            image: 'images/Group 2806.png',
            title: 'Delivery Arrived',
            subtitle: 'Order is arrived at your Place')
      ],
    );
  }
}
