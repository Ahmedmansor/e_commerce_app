import 'package:e_commerce_app/repos/colors.dart';
import 'package:e_commerce_app/repos/const.dart';
import 'package:e_commerce_app/utils/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../cubits/layout/cubit/layout_cubit.dart';
import '../models/product_model.dart';

// ignore: must_be_immutable
class ProductDetail extends StatelessWidget {
  ProductDetail({super.key, required this.productitem});
  final pageController = PageController();
  Products? productitem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondColor,
      appBar: AppBar(
        title: Text(
          productitem!.name!,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            BlocBuilder<LayoutCubit, LayoutState>(
              builder: (context, state) {
                return state is LoadingGetBannersState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        children: [
                          SizedBox(
                            height: AppSettings.height * 0.4,
                            child: PageView.builder(
                              controller: pageController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: productitem!.images!.length,
                              itemBuilder: (context, innerIndex) {
                                // var item = LayoutCubit.get(context)
                                //     .productModel!
                                //     .data!
                                //     .products![innerIndex];
                                return Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: Image.network(
                                    productitem!.images![innerIndex],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: GestureDetector(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: fourthColor,
                                child: Icon(
                                  Icons.favorite,
                                  color: LayoutCubit.get(context)
                                          .favoritesID
                                          .contains(productitem!.id.toString())
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 40,
                                ),
                              ),
                              onTap: () {
                                LayoutCubit.get(context)
                                    .addOrRemoveFromFavorites(
                                        productId: productitem!.id.toString());
                              },
                            ),
                          ),
                        ],
                      );
              },
            ),
            SizedBox(height: AppSettings.height * 0.01),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: productitem!.images!.length,
                axisDirection: Axis.horizontal,
                effect: const SlideEffect(
                    spacing: 8.0,
                    radius: 50.0,
                    dotWidth: 16.0,
                    dotHeight: 16.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.black,
                    activeDotColor: Colors.white),
              ),
            ),
            SizedBox(
              height: AppSettings.height * 0.01,
            ),
            Text(
              productitem!.description!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: AppSettings.height * 0.01,
            ),
            Row(
              children: [
                Text(
                  'Price: \$${productitem!.price!.toStringAsFixed(2)}',
                  style: ThemeText.medumFontBold.copyWith(color: thirdColor),
                ),
                SizedBox(
                  width: AppSettings.width * 0.05,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Discount: ',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              Colors.white, // Style for the "Discount: " text
                        ),
                      ),
                      TextSpan(
                        text: '${productitem!.discount!}%',
                        style: const TextStyle(
                          fontSize: 20,
                          color:
                              Colors.red, // Style for the discount percentage
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppSettings.height * 0.01,
            ),
            Text(
              'Old Price: \$${productitem!.oldPrice!.toStringAsFixed(2)}',
              style: ThemeText.medumFontBold.copyWith(
                  color: Colors.white,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 20),
            ),
            SizedBox(
              height: AppSettings.height * 0.03,
            ),
            Column(
              children: [
                BlocListener<LayoutCubit, LayoutState>(
                  listener: (context, state) {
                    if (state is SucessAddOrRemoveCartsState) {
                      Fluttertoast.showToast(
                          msg: "the item added or remover Sucessfully",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: SizedBox(
                    width: AppSettings.width * 0.4,
                    child: MaterialButton(
                      color: fourthColor,
                      onPressed: () {
                        LayoutCubit.get(context).addOrRemoveFromCart(
                            productId: productitem!.id!.toString());
                      },
                      child: const Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
