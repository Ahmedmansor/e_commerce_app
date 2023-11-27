import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:e_commerce_app/repos/colors.dart';
import 'package:e_commerce_app/repos/const.dart';
import 'package:e_commerce_app/utils/app_setting.dart';
import 'package:e_commerce_app/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var oldPasswordController = TextEditingController();

  var enterNewPasswordController = TextEditingController();

  var reEnterNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            height: AppSettings.height,
            width: AppSettings.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/loginBg.jpg'), fit: BoxFit.fill),
            ),
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  // height: AppSettings.height,
                  width: AppSettings.width,
                  decoration: BoxDecoration(
                    color: fourthColor.withOpacity(0.95),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      Form(
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: AuthCubit.get(context).keyChangePassword,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppSettings.height * 0.050,
                            ),
                            const Text(
                              'Change Password',
                              style: ThemeText.boardingScreenBody,
                            ),

                            SizedBox(
                              height: AppSettings.height * 0.05,
                            ),

                            //---

                            SizedBox(
                              height: AppSettings.height * 0.03,
                            ),

                            // Enter old Password
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return TextFormField(
                                  controller: oldPasswordController,
                                  onChanged: (value) {
                                    // chat gpt: the set state

                                    // AuthCubit.get(context)
                                    //     .validateFormLogin(); // _key.currentState!.validate();
                                    AuthCubit.get(context)
                                        .validateFormChangePassword(
                                            oldPassword: value,
                                            newPassword:
                                                enterNewPasswordController.text,
                                            reEnterPassword:
                                                reEnterNewPasswordController
                                                    .text);
                                    // _key.currentState!.validate();
                                    AuthCubit.get(context)
                                        .keyChangePassword
                                        .currentState!
                                        .validate();
                                  },
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "password must be at least 8 characters";
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(value)) {
                                      return "password formate is not correct";
                                    }
                                    return null;
                                  },
                                  obscureText:
                                      AuthCubit.get(context).isPassword,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: "Old Password",
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        AuthCubit.get(context)
                                            .changeVisablity();
                                      },
                                      icon: Icon(
                                          AuthCubit.get(context).isPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(
                              height: AppSettings.height * 0.01,
                            ),

                            // Enter New Password
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return TextFormField(
                                  controller: enterNewPasswordController,
                                  onChanged: (value) {
                                    // chat gpt: the set state

                                    // AuthCubit.get(context)
                                    //     .validateFormLogin(); // _key.currentState!.validate();
                                    AuthCubit.get(context)
                                        .validateFormChangePassword(
                                            oldPassword:
                                                oldPasswordController.text,
                                            newPassword: value,
                                            reEnterPassword:
                                                reEnterNewPasswordController
                                                    .text);
                                    // _key.currentState!.validate();
                                    AuthCubit.get(context)
                                        .keyChangePassword
                                        .currentState!
                                        .validate();
                                  },
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "password must be at least 8 characters";
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(value)) {
                                      return "password formate is not correct";
                                    } else if (enterNewPasswordController
                                            .text !=
                                        reEnterNewPasswordController.text) {
                                      return "the password is not match";
                                    }
                                    return null;
                                  },
                                  obscureText:
                                      AuthCubit.get(context).newPassword,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: "enter new Password",
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        AuthCubit.get(context)
                                            .changeNewPasswordVisablity();
                                      },
                                      icon: Icon(
                                          AuthCubit.get(context).newPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(
                              height: AppSettings.height * 0.01,
                            ),

                            // reEnter New Password
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return TextFormField(
                                  controller: reEnterNewPasswordController,
                                  onChanged: (value) {
                                    // chat gpt: the set state

                                    // AuthCubit.get(context)
                                    //     .validateFormLogin(); // _key.currentState!.validate();
                                    AuthCubit.get(context)
                                        .validateFormChangePassword(
                                            oldPassword:
                                                oldPasswordController.text,
                                            newPassword:
                                                enterNewPasswordController.text,
                                            reEnterPassword: value);
                                    // _key.currentState!.validate();
                                    AuthCubit.get(context)
                                        .keyChangePassword
                                        .currentState!
                                        .validate();
                                  },
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "password must be at least 8 characters";
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(value)) {
                                      return "password formate is not correct";
                                    } else if (reEnterNewPasswordController
                                            .text !=
                                        enterNewPasswordController.text) {
                                      return "the password is not match";
                                    }
                                    return null;
                                  },
                                  obscureText:
                                      AuthCubit.get(context).newPassword,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: "reEnter new Password",
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        AuthCubit.get(context)
                                            .changeNewPasswordVisablity();
                                      },
                                      icon: Icon(
                                          AuthCubit.get(context).newPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: AppSettings.height * 0.01,
                            ),

                            SizedBox(
                              width: AppSettings.width,
                              child: BlocConsumer<AuthCubit, AuthState>(
                                listener: (context, state) {
                                  if (state is SucessChangePasswordState) {
                                    // NavigationUtils.goToAndOff(
                                    //     context, LayoutScreen());
                                    NavigationUtils.offScreen(context);
                                    Fluttertoast.showToast(
                                        msg: "Password Changed Sucessfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (state
                                      is ErrorChangePasswordState) {
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.noHeader,
                                      body: Center(
                                        child: Text(
                                          state.message,
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      btnOkOnPress: () {},
                                    ).show();
                                  }
                                },
                                builder: (context, state) {
                                  return state is LoadingChangePasswordState
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : state is ChangePasswordValidState
                                          ? MaterialButton(
                                              // height: AppSettings.height * 0.08,
                                              onPressed: () {
                                                AuthCubit.get(context)
                                                    .changePassword(
                                                        oldPassword:
                                                            oldPasswordController
                                                                .text,
                                                        newPassword:
                                                            reEnterNewPasswordController
                                                                .text);
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              color: Colors.deepPurple,
                                              child: const Text(
                                                'Change Password',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            )
                                          : const ElevatedButton(
                                              onPressed: null,
                                              child: Text('Change Password',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white)));
                                },
                              ),
                            ),
                            SizedBox(
                              height: AppSettings.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
