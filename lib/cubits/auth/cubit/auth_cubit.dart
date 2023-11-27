import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/repos/dio_helper.dart';
import 'package:e_commerce_app/repos/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../repos/const.dart';
import '../../../repos/shared_pref_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

// chang visability
  bool isPassword = true;
  void changeVisablity() {
    isPassword = !isPassword;
    emit(ChangeVisabilityState());
  }

  // register servece
  register(String name, String email, String password, String phone) async {
    emit(LoadingRegisterState());
    await DioHelper.dio.post(registerEndPoint, data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone
    }).then((value) {
      if (value.data['status'] == true) {
        emit(SucessRegisterState());
        debugPrint('register sucess 200');
      } else {
        emit(ErrorRegisterState(message: value.data['message']));
        debugPrint(value.data['message']);
      }
    }).catchError((error) {
      emit(ErrorRegisterState(message: error.toString()));
      debugPrint(error.toString());
    });
  }

  // register Screen validate form
  var keyRegister = GlobalKey<FormState>();

  void validateFormRegister({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) {
    if (keyRegister.currentState!.validate()) {
      emit(RegisterValidState());
    } else {
      emit(RegisterInValidState());
    }
  }

  // login servece
  login(String email, String password) async {
    emit(LoadingLoginState());
    await DioHelper.dio.post(loginEndPoint, data: {
      "email": email,
      "password": password,
    }).then((value) {
      if (value.data["status"] == true) {
        CachMemory.insertToCachMemory(
            key: 'token', value: value.data['data']['token']);
        debugPrint('login sucess 200');

        debugPrint(
            'the token in cach is ${CachMemory.getFromCachMemory(key: 'token')}');
        emit(SucessLoginState());
      } else {
        emit(ErrorLoginState(message: value.data['message']));
        debugPrint('error to login ${value.data["message"]}');
      }
    }).catchError((error) {
      emit(ErrorLoginState(message: error.toString()));
      debugPrint(error.toString());
    });
  }

  // login Screen validate form
  var keyLogin = GlobalKey<FormState>();

  void validateFormLogin({
    required String email,
    required String password,
  }) {
    if (keyLogin.currentState!.validate()) {
      emit(LoginValidState());
    } else {
      emit(LoginInValidState());
    }
  }

// change password servece
  changePassword(
      {required String oldPassword, required String newPassword}) async {
    emit(LoadingChangePasswordState());
    await DioHelper.dio
        .post(changePasswordEndPoint,
            data: {
              "current_password": oldPassword,
              "new_password": newPassword,
            },
            options: Options(headers: {
              'Authorization': token,
              'lang': 'en',
              'Content-Type': 'application/json',
            }))
        .then((value) {
      if (value.data['status'] == true) {
        emit(SucessChangePasswordState());
      } else {
        emit(ErrorChangePasswordState(message: value.data['message']));
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  // change password Screen validate form
  var keyChangePassword = GlobalKey<FormState>();

  void validateFormChangePassword(
      {required String oldPassword,
      required String newPassword,
      required String reEnterPassword}) {
    if (keyChangePassword.currentState!.validate()) {
      emit(ChangePasswordValidState());
    } else {
      emit(ChangePasswordInvalidState());
    }
  }

  //change password Screen visabbility password
  bool newPassword = true;
  void changeNewPasswordVisablity() {
    newPassword = !newPassword;
    emit(ChangeVisabilityState2());
  }
}
