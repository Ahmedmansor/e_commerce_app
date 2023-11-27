import 'package:e_commerce_app/cubits/layout/cubit/layout_cubit.dart';
import 'package:e_commerce_app/repos/colors.dart';
import 'package:e_commerce_app/utils/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repos/const.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: [
              SizedBox(
                height: AppSettings.height * 0.01,
              ),
              Expanded(
                child: state is LoadingGetCartsState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: AppSettings.height * 0.02);
                        },
                        itemCount: LayoutCubit.get(context).carts.length,
                        itemBuilder: (context, index) {
                          var item = LayoutCubit.get(context).carts[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      item.image!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
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
                                      Text(
                                        item.name!,
                                        style: ThemeText.reularbold.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            color: mainColor),
                                      ),
                                      SizedBox(
                                          height: AppSettings.height * 0.01),
                                      Row(
                                        children: [
                                          Text('${item.price!}\$',
                                              style: ThemeText.reularbold),
                                          Text(
                                            '${item.oldPrice!}\$',
                                            style: ThemeText.reularbold
                                                .copyWith(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: AppSettings.height * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {
                                                LayoutCubit.get(context)
                                                    .addOrRemoveFromFavorites(
                                                        productId:
                                                            item.id.toString());
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: LayoutCubit.get(context)
                                                        .favoritesID
                                                        .contains(
                                                            item.id.toString())
                                                    ? Colors.red
                                                    : Colors.grey,
                                              )),
                                          GestureDetector(
                                            onTap: () {
                                              LayoutCubit.get(context)
                                                  .addOrRemoveFromCart(
                                                      productId:
                                                          item.id.toString());
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Container(
                child:
                    Text('Total Price: ${LayoutCubit.get(context).totalPrice}'),
              ),
            ],
          ),
        );
      },
    ));
  }
}
