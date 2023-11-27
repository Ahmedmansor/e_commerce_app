import 'package:e_commerce_app/utils/app_setting.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});
  final String? image;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSettings.defultSize * 25,
        ),
        SizedBox(
            height: AppSettings.defultSize * 25, child: Image.asset(image!)),
        SizedBox(
          height: AppSettings.defultSize * 5,
        ),
        Text(
          title!,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xff2f2e41),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: AppSettings.defultSize * 2,
        ),
        Text(
          subtitle!,
          style: const TextStyle(
              fontSize: 15,
              color: Color(0xff78787c),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
