import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/favorites_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repos/const.dart';
import 'package:e_commerce_app/repos/dio_helper.dart';
import 'package:e_commerce_app/repos/end_points.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/screens/categories_screen.dart';
import 'package:e_commerce_app/screens/favourite_screen.dart';
import 'package:e_commerce_app/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/banner_model.dart';
import '../../../models/category_model.dart';
import '../../../models/profile_model.dart';
import '../../../screens/home_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int index = 4;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void changeScreen(i) {
    index = i;
    emit(ChangeScreenState());
  }

  BannerModel? bannerModel;

  void getBanners() async {
    emit(LoadingGetBannersState());
    await DioHelper.dio.get(bannersEndPoint).then((value) {
      if (value.data["status"] == true) {
        emit(SucessGetBannersState());
        debugPrint('sucess get all banners');
        bannerModel = BannerModel.fromJson(value.data);
        print(bannerModel!.data!.length);
      } else {
        emit(ErrorGetBannersState());
      }
    }).catchError((error) {
      emit(ErrorGetCategoriesState());
      debugPrint(error.toString());
    });
  }

  CategoryModel? categoryModel;
  void getAllCategories() async {
    emit(LoadingGetCategoriesState());

    await DioHelper.dio
        .get(categoriesEndPoint, options: Options(headers: {'lang': 'en'}))
        .then((value) {
      if (value.data["status"] == true) {
        emit(SucessGetCategoriesState());
        debugPrint('sucess get all Categories');

        categoryModel = CategoryModel.fromJson(value.data['data']);
        print(categoryModel!.data!.length);
      } else {
        emit(ErrorGetCategoriesState());
        debugPrint('ُerror get all Categories');
      }
    }).catchError((error) {
      emit(ErrorGetCategoriesState());
      debugPrint(error.toString());
    });
  }

  //second
  // List<CategoryModel> categories = [];
  // void getAllCategories() async {
  //   emit(LoadingGetCategoriesState());
  //   categories = [];
  //   await DioHelper.dio.get(categoriesEndPoint).then((value) {
  //     if (value.data["status"] == true) {
  //       debugPrint('sucess get all Categories');
  //       emit(SucessGetCategoriesState());

  //       for (var element in value.data) {
  //         categories.add(CategoryModel.fromJson(element));
  //       }
  //       print(categories.length);
  //     } else {
  //       emit(ErrorGetCategoriesState());
  //     }
  //   }).catchError((error) {
  //     emit(ErrorGetCategoriesState());

  //     print(error);
  //   });
  // }

  //getAllProducts
  ProductModel? productModel;
  void getAllProducts() async {
    emit(LoadingGetProductsState());

    await DioHelper.dio
        .get(
      productsEndPoint,
      options: Options(headers: {
        'lang': 'en',
      }),
    )
        .then((value) {
      if (value.data['status'] == true) {
        emit(SucessGetProductsState());

        debugPrint('SucessGetProductsState');
        productModel = ProductModel.fromJson(value.data);
        print(productModel!.data!.products!.length);
        // print(value.data);
      } else {
        emit(ErrorGetProductsState());
        debugPrint('ErrorGetProductsState');
        print(value.data);
      }
    }).catchError((error) {
      emit(ErrorGetProductsState());

      print(error.toString());
    });
  }

  //filtered jobs
  List<Products> filteredProductsList = [];

  void filteredProducts({required String input}) {
    List<Products> allProducts = productModel!.data!.products!;

    filteredProductsList = allProducts
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    print(filteredProductsList.length);
    emit(SucessFilterProductsState());
  }

  //get all favorites
  FavoritesModel? favoritesModel;
  List<ProductFavorites> favorites = [];
// set مفيش تكرار
  Set<String> favoritesID = {};

  Future getAllFavorites() async {
    emit(LoadingGetFavoritesState());
    favorites = [];

    DioHelper.dio
        .get(favoritesEndPoint,
            options: Options(headers: {'Authorization': token, 'lang': 'en'}))
        .then((value) {
      if (value.data['status'] == true) {
        emit(SucessGetFavoritesState());
        print('in All favourites');
        //
        // favoritesModel = FavoritesModel.fromJson(value.data);
        // print(favoritesModel!.data!.length);
        //
        for (var element in value.data['data']['data']) {
          favorites.add(ProductFavorites.fromJson(element));
          print(element);
          print('favourites = ${favorites.length}');
          // print(favorites[index].oldPrice);

          favoritesID.add(element['product']['id'].toString());
          print('favouritesID = ${favoritesID.length}');
        }
      } else {
        emit(ErrorGetFavoritesState());
        debugPrint('ErrorGetFavorites');
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  void addOrRemoveFromFavorites({required String productId}) async {
    await DioHelper.dio
        .post(favoritesEndPoint,
            data: {
              'product_id': productId,
            },
            options: Options(headers: {
              'lang': 'en',
              'Authorization': token,
            }))
        .then((value) {
      if (value.data['status'] == true) {
        if (favoritesID.contains(productId) == true) {
          favoritesID.remove(productId);
        } else {
          favoritesID.add(productId);
        }
        getAllFavorites();
        emit(SucessAddOrRemoveFavoritesState());
      } else {
        emit(ErrorAddOrRemoveFavoritesState());
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  //get all carts
  List<Cart> carts = [];
  int totalPrice = 0;
  Set<String> cartsID = {};

  Future getAllCarts() async {
    emit(LoadingGetCartsState());
    carts = [];

    DioHelper.dio
        .get(cartsEndPoint,
            options: Options(headers: {'Authorization': token, 'lang': 'en'}))
        .then((value) {
      //totalPrice
      totalPrice = value.data['data']['total'];

      if (value.data['status'] == true) {
        emit(SucessGetCartsState());
        debugPrint('in All carts');

        for (var element in value.data['data']['cart_items']) {
          carts.add(Cart.fromJson(element));
          debugPrint('carts = ${carts.length}');

          cartsID.add(element['product']['id'].toString());
          debugPrint('cartsID = ${cartsID.length}');
        }
      } else {
        emit(ErrorGetCartsState());
        debugPrint('ErrorGetCarts');
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  //add or remove products from cart
  void addOrRemoveFromCart({required String productId}) async {
    await DioHelper.dio
        .post(cartsEndPoint,
            data: {
              'product_id': productId,
            },
            options: Options(headers: {
              'lang': 'en',
              'Authorization': token,
            }))
        .then((value) {
      if (value.data['status'] == true) {
        if (cartsID.contains(productId) == true) {
          cartsID.remove(productId);
        } else {
          cartsID.add(productId);
        }
        getAllCarts();
        emit(SucessAddOrRemoveCartsState());
      } else {
        emit(ErrorAddOrRemoveCartsState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  // get Profile Data
  ProfileData? profileData;
  getProfileData() async {
    emit(LoadingGetProfileState());

    await DioHelper.dio
        .get(
      profileEndPoint,
      options: Options(headers: {
        'lang': 'en',
        'Authorization': token,
      }),
    )
        .then((value) {
      if (value.data['status'] == true) {
        debugPrint('in get profile data');
        profileData = ProfileData.fromJson(value.data['data']);
        debugPrint(profileData!.email);
        emit(SucessGetProfileState());
      } else {
        emit(ErrorGetProfileState());
      }
    }).catchError((e) {
      emit(ErrorGetProfileState());

      debugPrint(e.toString());
    });
  }

  //update Profile
  // ProfileData? profileData1;
  updateProfile(
      {required String name,
      required String email,
      required String phone}) async {
    debugPrint('in update Profile0');
    emit(LoadingUpdateProfileState());
    await DioHelper.dio
        .put(updateProfileEndPoint,
            data: {'name': name, 'email': email, 'phone': phone},
            options: Options(headers: {
              'Authorization': token,
              'lang': "en",
              'Content-Type': 'application/json'
            }))
        .then((value) {
      // debugPrint(value.data['status']);
      if (value.data['status'] == true) {
        debugPrint('in update Profile1');
        getProfileData();
        emit(SucessUpdateProfileState());
      } else {
        emit(ErrorUpdateProfileState());
      }
    }).catchError((e) {
      emit(ErrorUpdateProfileState());

      debugPrint(e.toString());
    });
  }
}
