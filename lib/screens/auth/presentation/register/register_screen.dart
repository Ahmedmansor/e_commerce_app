import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../repos/const.dart';
import '../../../../../utils/navigation_util.dart';
import '../../../../cubits/auth/cubit/auth_cubit.dart';
import '../../../../utils/app_setting.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: AuthCubit.get(context).keyRegister,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSettings.height * 0.1,
                ),
                const Text(
                  'Create Account',
                  style: ThemeText.boardingScreenBody,
                ),
                const Text(
                  'Please Create an account to discover catchy products',
                  style: ThemeText.boardingScreenBodysmall,
                ),
                SizedBox(
                  height: AppSettings.height * 0.05,
                ),
                //username
                TextFormField(
                  controller: userNameController,
                  onChanged: (value) {
                    AuthCubit.get(context).validateFormRegister(
                        username: value,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username can't be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Username",
                    prefixIcon: const Icon(Icons.person_2_outlined),
                  ),
                ),
                SizedBox(
                  height: AppSettings.height * 0.03,
                ),

                //email
                TextFormField(
                  controller: emailController,
                  onChanged: (value) {
                    AuthCubit.get(context).validateFormRegister(
                        username: userNameController.text,
                        email: value,
                        password: passwordController.text,
                        phone: phoneController.text);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email can't be empty";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "email formate is not correct";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(
                  height: AppSettings.height * 0.03,
                ),

                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    //password
                    return TextFormField(
                      controller: passwordController,
                      onChanged: (value) {
                        AuthCubit.get(context).validateFormRegister(
                            username: userNameController.text,
                            email: emailController.text,
                            password: value,
                            phone: phoneController.text);
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
                      obscureText: AuthCubit.get(context).isPassword,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changeVisablity();
                          },
                          icon: Icon(AuthCubit.get(context).isPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: AppSettings.height * 0.03,
                ),
                //phone
                TextFormField(
                  controller: phoneController,
                  onChanged: (value) {
                    AuthCubit.get(context).validateFormRegister(
                        username: userNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "phone can't be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "phone",
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                // MaterialButton(
                //   onPressed: () {
                //     if (_key.currentState!.validate()) {
                //       print("success");
                //     }
                //   },
                //   color: Colors.redAccent,
                //   textColor: Colors.white,
                //   child: const Text(
                //     "Login",
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                //   minWidth: 200,
                // ),
                SizedBox(
                  height: AppSettings.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: ThemeText.boardingScreenBodysmall,
                    ),
                    TextButton(
                      onPressed: () {
                        // NavigationUtils.goToAndOff(context, LoginScreen());
                      },
                      child: Text(
                        'Login',
                        style: ThemeText.boardingScreenBodysmall
                            .copyWith(color: Colors.blue[800]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSettings.height * 0.01),
                /********************/

                SizedBox(
                  width: AppSettings.width,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is SucessRegisterState) {
                        Fluttertoast.showToast(
                            msg: "Registerd Sucessfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        NavigationUtils.offScreen(context);
                      } else if (state is ErrorRegisterState) {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.noHeader,
                          body: Center(
                            child: Text(
                              state.message,
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          btnOkOnPress: () {},
                        ).show();
                      }
                    },
                    builder: (context, state) {
                      return state is LoadingRegisterState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : state is RegisterValidState
                              ? MaterialButton(
                                  // height: AppSettings.height * 0.08,
                                  onPressed: () {
                                    AuthCubit.get(context).register(
                                        userNameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        phoneController.text);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  color: Colors.blue[400],
                                  child: const Text(
                                    'Create Account',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                )
                              : const ElevatedButton(
                                  onPressed: null,
                                  child: Text('Create Account',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)));
                      //  MaterialButton(
                      //     height: AppSettings.height * 0.08,
                      //     onPressed: () {
                      //       AuthenticationCubit.get(context).register(
                      //           userNameController.text,
                      //           emailController.text,
                      //           passwordController.text);
                      //     },
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(50)),
                      //     color: Colors.blueAccent,
                      //     child: Text(
                      //       'Create Account',
                      //       style: TextStyle(
                      //           fontSize: 16, color: Colors.white),
                      //     ),
                      //   );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSettings.height * 0.02,
                ),
                SizedBox(
                  width: AppSettings.width,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSettings.height * 0.03,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     SocialMedia(
                //         text: 'Google', icon: 'assets/social/Google.png'),
                //     SocialMedia(
                //         text: 'Facebook', icon: 'assets/social/Facebook.png')
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
