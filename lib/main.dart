// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:phone_validation_with_firebase_bloc/screens/home_screen.dart';
import 'package:phone_validation_with_firebase_bloc/screens/phone_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Phone Auth with firebase and bloc',
          home: BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (oldState, newState) {
              return oldState is AuthInitState;
            },
            builder: (context, state) {
              if (state is AuthLoggedInState) {
                return HomeScreen();
              } else if (state is AuthLoggedOutState) {
                return PhoneAuth();
              } else {
                return Scaffold();
              }
            },
          )),
    );
  }
}
