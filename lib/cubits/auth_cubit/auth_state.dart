import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthOTPSentState extends AuthState {}

class AuthOTPVerifyState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User firebaseUser;
  AuthLoggedInState({
    required this.firebaseUser,
  });
}

class AuthLoggedOutState extends AuthState {}

class AuthErrorState extends AuthState {
  String errorMessage;
  AuthErrorState({required this.errorMessage});
}
