part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//! -------------------------
class LoadingRegisterState extends AuthState {}

class SucessRegisterState extends AuthState {}

class ErrorRegisterState extends AuthState {
  String message;
  ErrorRegisterState({required this.message});
}

//! -------------------------
class ChangeVisabilityState extends AuthState {}

class ChangeVisabilityState2 extends AuthState {}

//! -------------------------
class LoadingLoginState extends AuthState {}

class SucessLoginState extends AuthState {}

class ErrorLoginState extends AuthState {
  String message;
  ErrorLoginState({required this.message});
}

//! -------------------------
class ChangePasswordValidState extends AuthState {}

class ChangePasswordInvalidState extends AuthState {}

//! -------------------------
class LoadingChangePasswordState extends AuthState {}

class SucessChangePasswordState extends AuthState {}

class ErrorChangePasswordState extends AuthState {
  String message;
  ErrorChangePasswordState({required this.message});
}

//! -------------------------
class RegisterValidState extends AuthState {}

class RegisterInValidState extends AuthState {}

//! -------------------------
class LoginValidState extends AuthState {}

class LoginInValidState extends AuthState {}
