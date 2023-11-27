import 'package:flutter/material.dart';

import '../utils/app_setting.dart';

class SocialMedia extends StatelessWidget {
  SocialMedia({super.key, this.text, this.icon});

  String? text;
  String? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSettings.height * 0.06,
      width: AppSettings.width * 0.43,
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            side: BorderSide(color: Colors.black12)),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon!,
              scale: 40,
            ),
            Text(
              '   $text',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
