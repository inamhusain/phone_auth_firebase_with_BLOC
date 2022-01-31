// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:phone_validation_with_firebase_bloc/screens/phone_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PhoneAuth(),
                ));
          }
        },
        builder: (context, state) { 
          return MaterialButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logOut();
            },
            color: Colors.lightBlue,
            child: Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      )),
    );
  }
}
