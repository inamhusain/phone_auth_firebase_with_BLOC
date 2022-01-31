// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:phone_validation_with_firebase_bloc/screens/home_screen.dart';

class VerifyPhoneNo extends StatelessWidget {
  VerifyPhoneNo({Key? key}) : super(key: key);
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('verify Phone with otp'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                label: Text('6-Digit OTP'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedInState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AuthErrorState) {
                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ));
                  });
                }
                return MaterialButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context)
                        .verifyOtp(otp: otpController.text);
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  shape: StadiumBorder(),
                  color: Colors.lightBlue,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
