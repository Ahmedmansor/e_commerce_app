import 'package:e_commerce_app/cubits/layout/cubit/layout_cubit.dart';
import 'package:e_commerce_app/repos/colors.dart';
import 'package:e_commerce_app/utils/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/favorites_model.dart';
import '../repos/const.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //important
    // List<ProductFavorites> favoritesList = LayoutCubit.get(context).favorites;

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return LayoutCubit.get(context).favorites.isEmpty
            ? const CircularProgressIndicator()
            : Scaffold(
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                      ),
                      SizedBox(
                        height: AppSettings.height * 0.03,
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: AppSettings.height * 0.02,
                            );
                          },
                          itemCount: LayoutCubit.get(context).favorites.length,
                          itemBuilder: (context, index) {
                            var item =
                                LayoutCubit.get(context).favorites[index];
                            return Container(
                              color: Colors.grey.withOpacity(0.4),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      item.image!,
                                      width: 120,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppSettings.width * 0.01,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(item.id.toString()),

                                        Text(
                                          item.name!,
                                          style: ThemeText.reularbold.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              color: mainColor),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            LayoutCubit.get(context)
                                                .addOrRemoveFromFavorites(
                                                    productId:
                                                        item.id.toString());
                                          },
                                          child: Text('remove'),
                                          color: mainColor,
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
