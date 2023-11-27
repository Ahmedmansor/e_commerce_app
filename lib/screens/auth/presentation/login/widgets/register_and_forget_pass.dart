import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../repos/const.dart';
import '../../../../../utils/app_setting.dart';
import '../../../../../utils/navigation_util.dart';
import '../../ChangePassword/change_password.dart';
import '../../register/register_screen.dart';

class RegisterAndForgetPassword extends StatelessWidget {
  const RegisterAndForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dont’t have an account?',
              style: ThemeText.boardingScreenBodysmall,
            ),
            TextButton(
              onPressed: () {
                NavigationUtils.goTo(context, const RegisterScreen());
              },
              child: Text(
                'Register',
                style: ThemeText.boardingScreenBodysmall
                    .copyWith(color: Colors.blue[800]),
              ),
            ),
          ],
        ),
        RichText(
          text: TextSpan(children: [
            const TextSpan(
                text: 'forget your password  ',
                style: ThemeText.boardingScreenBodysmall),
            TextSpan(
              text: 'Click here',
              style: ThemeText.boardingScreenBodysmall
                  .copyWith(color: Colors.blue[800]),
              recognizer: TapGestureRecognizer()
                ..onTap = () => NavigationUtils.goTo(context, ChangePassword()),
            ),
          ]),
        ),
        SizedBox(
          height: AppSettings.height * 0.03,
        ),
      ],
    );
  }
}
