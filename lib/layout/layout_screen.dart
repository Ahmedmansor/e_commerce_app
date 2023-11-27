import 'package:e_commerce_app/cubits/layout/cubit/layout_cubit.dart';
import 'package:e_commerce_app/repos/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: thirdColor,
          appBar: AppBar(
            title: SvgPicture.asset(
              'images/logo.svg',
              height: 40,
              width: 40,
              color: mainColor,
            ),
            elevation: 0,
          ),
          body:
              LayoutCubit.get(context).screens[LayoutCubit.get(context).index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: LayoutCubit.get(context).index,
            onTap: (value) {
              LayoutCubit.get(context).changeScreen(value);
            },
            selectedItemColor: Colors.deepOrange,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: "Favourites",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                ),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
