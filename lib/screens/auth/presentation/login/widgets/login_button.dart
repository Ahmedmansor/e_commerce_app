import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../cubits/auth/cubit/auth_cubit.dart';
import '../../../../../layout/layout_screen.dart';
import '../../../../../repos/colors.dart';
import '../../../../../utils/app_setting.dart';
import '../../../../../utils/navigation_util.dart';

class LoginButton extends StatelessWidget {
  LoginButton(
      {super.key,
      required this.emailController,
      required this.passwordController});

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSettings.width,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SucessLoginState) {
            NavigationUtils.goToAndOff(context, const LayoutScreen());
            Fluttertoast.showToast(
                msg: "Login Sucessfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is ErrorLoginState) {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.noHeader,
              body: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              btnOkOnPress: () {},
            ).show();
          }
        },
        builder: (context, state) {
          return state is LoadingLoginState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is LoginValidState
                  ? MaterialButton(
                      // height: AppSettings.height * 0.08,
                      onPressed: () async {
                        AuthCubit.get(context).login(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: mainColor,
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  : const ElevatedButton(
                      onPressed: null,
                      child: Text('Login',
                          style: TextStyle(fontSize: 16, color: Colors.white)));
        },
      ),
    );
  }
}
