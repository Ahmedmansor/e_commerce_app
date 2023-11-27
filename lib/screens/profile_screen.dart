import 'package:e_commerce_app/cubits/layout/cubit/layout_cubit.dart';
import 'package:e_commerce_app/repos/colors.dart';
import 'package:e_commerce_app/repos/const.dart';
import 'package:e_commerce_app/screens/auth/presentation/ChangePassword/change_password.dart';
import 'package:e_commerce_app/utils/app_setting.dart';
import 'package:e_commerce_app/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: ProfileCard(),
    );
  }
}

// ignore: must_be_immutable
class ProfileCard extends StatelessWidget {
  ProfileCard({super.key});
  var nameController = TextEditingController();
  var emailcontroller = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileItem = LayoutCubit.get(context).profileData;
    nameController.text = profileItem!.name!;
    emailcontroller.text = profileItem.email!;
    phoneController.text = profileItem.phone!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is SucessUpdateProfileState) {
            Fluttertoast.showToast(
                msg: "Profile Data Changed Sucessfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return state is LoadingUpdateProfileState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profileItem.image!),
                      ),
                    ),
                    SizedBox(height: AppSettings.height * 0.01),
                    const Text(
                      'name',
                      style: ThemeText.iconsNameBold,
                    ),
                    profileTextFormField(
                        name: 'name',
                        iconData: Icons.person,
                        controller: nameController),
                    SizedBox(
                      height: AppSettings.height * 0.01,
                    ),
                    const Text(
                      'e-mail',
                      style: ThemeText.iconsNameBold,
                    ),
                    profileTextFormField(
                        name: 'email',
                        iconData: Icons.email_outlined,
                        controller: emailcontroller),
                    SizedBox(
                      height: AppSettings.height * 0.01,
                    ),
                    const Text(
                      'phone',
                      style: ThemeText.iconsNameBold,
                    ),
                    profileTextFormField(
                        name: 'phone',
                        iconData: Icons.phone_android_outlined,
                        controller: phoneController),
                    SizedBox(
                      height: AppSettings.height * 0.1,
                    ),
                    Center(
                      child: BlocBuilder<LayoutCubit, LayoutState>(
                        builder: (context, state) {
                          return state is LoadingUpdateProfileState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : MaterialButton(
                                  onPressed: () {
                                    LayoutCubit.get(context).updateProfile(
                                        name: nameController.text,
                                        email: emailcontroller.text,
                                        phone: phoneController.text);
                                  },
                                  color: secondColor,
                                  child: const Text('Update Data'),
                                );
                        },
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () {
                          NavigationUtils.goTo(context, ChangePassword());
                        },
                        color: secondColor,
                        child: const Text('Change Password'),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }

  TextFormField profileTextFormField(
      {required TextEditingController controller,
      required IconData iconData,
      required String name}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusColor: mainColor,
          prefixIcon: Icon(iconData),
          hintText: name),
    );
  }
}
