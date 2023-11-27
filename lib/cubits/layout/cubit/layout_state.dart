part of 'layout_cubit.dart';

@immutable
sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}

class ChangeScreenState extends LayoutState {}

//! -------------------------------
class LoadingGetBannersState extends LayoutState {}

class SucessGetBannersState extends LayoutState {}

class ErrorGetBannersState extends LayoutState {}

//! -------------------------------
class LoadingGetCategoriesState extends LayoutState {}

class SucessGetCategoriesState extends LayoutState {}

class ErrorGetCategoriesState extends LayoutState {}

//! -------------------------------
class LoadingGetProductsState extends LayoutState {}

class SucessGetProductsState extends LayoutState {}

class ErrorGetProductsState extends LayoutState {}

//! -------------------------------
class SucessFilterProductsState extends LayoutState {}

//! -------------------------------
class LoadingGetFavoritesState extends LayoutState {}

class SucessGetFavoritesState extends LayoutState {}

class ErrorGetFavoritesState extends LayoutState {}

//! -------------------------------

class SucessAddOrRemoveFavoritesState extends LayoutState {}

class ErrorAddOrRemoveFavoritesState extends LayoutState {}

//! -------------------------------
class LoadingGetCartsState extends LayoutState {}

class SucessGetCartsState extends LayoutState {}

class ErrorGetCartsState extends LayoutState {}
//! -------------------------------

class SucessAddOrRemoveCartsState extends LayoutState {}

class ErrorAddOrRemoveCartsState extends LayoutState {}

//! -------------------------------
class LoadingGetProfileState extends LayoutState {}

class SucessGetProfileState extends LayoutState {}

class ErrorGetProfileState extends LayoutState {}

//! -------------------------------
class LoadingUpdateProfileState extends LayoutState {}

class SucessUpdateProfileState extends LayoutState {}

class ErrorUpdateProfileState extends LayoutState {}
