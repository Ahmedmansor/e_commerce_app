import 'package:e_commerce_app/cubits/layout/cubit/layout_cubit.dart';
import 'package:e_commerce_app/layout/layout_screen.dart';
import 'package:e_commerce_app/on%20Boarding/presentation/boarding_view.dart';
import 'package:e_commerce_app/on%20Boarding/presentation/widgets/on_boarding_body.dart';
import 'package:e_commerce_app/repos/const.dart';
import 'package:e_commerce_app/screens/auth/presentation/register/register_screen.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/cubit/auth_cubit.dart';
import '../screens/auth/presentation/ChangePassword/change_password.dart';
import '../screens/auth/presentation/login/login_screen.dart';
import '../screens/product_detail.dart';
import '../utils/app_setting.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettings.init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
            create: (context) => LayoutCubit()
              ..getAllCategories()
              ..getBanners()
              ..getAllProducts()
              ..getAllFavorites()
              ..getAllCarts()
              ..getProfileData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        // home: SplashScreen(),
        // home: RegisterScreen(),
        home: LoginScreen(),
        // home: Test(),
        // home: ProductDetail(),
        // home: token != null && token != "" ? LayoutScreen() : LoginScreen(),
        // home: ChangePassword(),
        // home: OnBoarding(),
      ),
    );
  }
}
