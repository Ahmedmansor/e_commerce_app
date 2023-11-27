import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repos/colors.dart';
import 'package:e_commerce_app/repos/const.dart';
import 'package:e_commerce_app/screens/product_detail.dart';
import 'package:e_commerce_app/utils/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../cubits/layout/cubit/layout_cubit.dart';
import '../utils/navigation_util.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  onChanged: (input) {
                    LayoutCubit.get(context).filteredProducts(input: input);
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      labelText: "Search",
                      suffixIcon: const Icon(Icons.clear),
                      // contentPadding: EdgeInsets.zero,
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true),
                ),
              ),
              SizedBox(height: AppSettings.height * 0.01),
              state is LoadingGetBannersState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: AppSettings.height * 0.15,
                      width: AppSettings.width,
                      child: PageView.builder(
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: LayoutCubit.get(context)
                                .bannerModel
                                ?.data!
                                .length ??
                            0,
                        itemBuilder: (context, index) {
                          var item = LayoutCubit.get(context)
                              .bannerModel!
                              .data![index];
                          return Container(
                            margin: const EdgeInsets.only(right: 15),
                            child:
                                Image.network(item.image!, fit: BoxFit.cover),
                          );
                        },
                      ),
                    ),
              SizedBox(height: AppSettings.height * 0.01),
              state is LoadingGetBannersState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: LayoutCubit.get(context)
                                .bannerModel
                                ?.data
                                ?.length ??
                            0,
                        axisDirection: Axis.horizontal,
                        effect: const SlideEffect(
                            spacing: 8.0,
                            radius: 50.0,
                            dotWidth: 16.0,
                            dotHeight: 16.0,
                            paintStyle: PaintingStyle.stroke,
                            strokeWidth: 1.5,
                            dotColor: Colors.grey,
                            activeDotColor: secondColor),
                      ),
                    ),
              SizedBox(height: AppSettings.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: ThemeText.pageTitle.copyWith(color: mainColor),
                  ),
                  const Text(
                    'View All',
                    style: ThemeText.medumFontBlue,
                  ),
                ],
              ),
              SizedBox(height: AppSettings.height * 0.02),

              //
              state is LoadingGetCategoriesState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: AppSettings.height * 0.15,
                      width: AppSettings.width,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Padding(
                              padding: EdgeInsets.only(right: 15));
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: LayoutCubit.get(context)
                                .categoryModel
                                ?.data!
                                .length ??
                            0,
                        itemBuilder: (context, index) {
                          return CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                                LayoutCubit.get(context)
                                    .categoryModel!
                                    .data![index]
                                    .image!),
                            // backgroundColor: secondColor,
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: AppSettings.height * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products',
                      style: ThemeText.pageTitle.copyWith(color: mainColor),
                    ),
                    const Text(
                      'View All',
                      style: ThemeText.medumFontBlue,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSettings.height * 0.02,
              ),
              state is LoadingGetProductsState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          LayoutCubit.get(context).filteredProductsList.isEmpty
                              ? LayoutCubit.get(context)
                                      .productModel
                                      ?.data
                                      ?.products
                                      ?.length ??
                                  0
                              : LayoutCubit.get(context)
                                  .filteredProductsList
                                  .length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        var item = LayoutCubit.get(context)
                            .productModel!
                            .data!
                            .products![index];
                        return _productItem(
                            item: LayoutCubit.get(context)
                                    .filteredProductsList
                                    .isEmpty
                                ? item
                                : LayoutCubit.get(context)
                                    .filteredProductsList[index],
                            context: context);
                      },
                    ),
            ],
          ),
        ));
      },
    );
  }

  Widget _productItem({required Products item, required BuildContext context}) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            NavigationUtils.goTo(context, ProductDetail(productitem: item));
          },
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: Column(children: [
              Expanded(
                child: Image.network(
                  item.image!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: AppSettings.height * 0.01,
              ),
              Text(
                item.name!,
                style: ThemeText.reularbold
                    .copyWith(overflow: TextOverflow.ellipsis),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '${item.price}',
                                  style: ThemeText.reularbold),
                              const TextSpan(
                                text: '\$',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: AppSettings.width * 0.01,
                        ),
                        Text(
                          '${item.oldPrice}\$',
                          style: ThemeText.iconsNameBold.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.favorite,
                      color: LayoutCubit.get(context)
                              .favoritesID
                              .contains(item.id.toString())
                          ? Colors.red
                          : Colors.grey,
                      size: 20,
                    ),
                    onTap: () {
                      LayoutCubit.get(context).addOrRemoveFromFavorites(
                          productId: item.id.toString());
                    },
                  ),
                ],
              )
            ]),
          ),
        ),
        Positioned(
          top: -13,
          left: -13,
          child: IconButton(
            onPressed: () {
              LayoutCubit.get(context)
                  .addOrRemoveFromCart(productId: item.id.toString());
            },
            icon: Icon(
              Icons.shopping_cart,
              size: 25,
              color:
                  LayoutCubit.get(context).cartsID.contains(item.id.toString())
                      ? Colors.red
                      : Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
