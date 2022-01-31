// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitState()) {
    User? currentuser = _auth.currentUser;
    if (currentuser != null) {
      emit(AuthLoggedInState(firebaseUser: currentuser));
    } else {
      emit(AuthLoggedOutState());
    }
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  void sendOtp({required String phoneNo}) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthOTPSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(credential: phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(errorMessage: error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOtp({required String otp}) async {
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);

    signInWithPhone(credential: credential);
  }

  void signInWithPhone({required PhoneAuthCredential credential}) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential != null) {
        emit(AuthLoggedInState(firebaseUser: userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
