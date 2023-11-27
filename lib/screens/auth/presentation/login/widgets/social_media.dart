import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

import '../../../../../widgets/custom_buttoms.dart';

class SocialMediaRaw extends StatelessWidget {
  const SocialMediaRaw({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: CustomButtonWithIcon(
              color: const Color(0xFFdb3236),
              iconData: FontAwesomeIcons.google,
              text: 'Log in with ',
              onPressed: () {},
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: CustomButtonWithIcon(
              onPressed: () {},
              color: const Color(0xFF4267B2),
              iconData: FontAwesomeIcons.facebookF,
              text: 'Log in with ',
            ),
          ),
        )
      ],
    );
  }
}
