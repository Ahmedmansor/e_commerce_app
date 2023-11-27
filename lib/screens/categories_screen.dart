import 'package:e_commerce_app/cubits/layout/cubit/layout_cubit.dart';
import 'package:e_commerce_app/repos/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: BlocBuilder<LayoutCubit, LayoutState>(
            builder: (context, state) {
              return state is LoadingGetCategoriesState
                  ? CircularProgressIndicator()
                  : GridView.builder(
                      itemCount: LayoutCubit.get(context)
                              .categoryModel
                              ?.data
                              ?.length ??
                          0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.8),
                      itemBuilder: (context, index) {
                        var item = LayoutCubit.get(context)
                            .categoryModel!
                            .data![index];
                        return Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(item.image!,
                                    fit: BoxFit.cover),
                              ),
                              Text(
                                item.name!,
                                style: ThemeText.iconsNameBold
                                    .copyWith(color: Colors.black),
                              )
                            ],
                          ),
                        );
                      },
                    );
            },
          )),
    );
  }
}
