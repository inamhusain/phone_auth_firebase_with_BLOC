// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_string_interpolations, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_cubit.dart';
import 'package:phone_validation_with_firebase_bloc/cubits/auth_cubit/auth_state.dart';
import 'package:phone_validation_with_firebase_bloc/screens/verify_phone_no.dart';

class PhoneAuth extends StatelessWidget {
  PhoneAuth({Key? key}) : super(key: key);
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In With Phone'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                label: Text('Phone No'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthOTPSentState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyPhoneNo(),
                      ));
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return MaterialButton(
                  onPressed: () {
                    String _phoneNo = "+91" + "${phoneController.text}";
                    BlocProvider.of<AuthCubit>(context)
                        .sendOtp(phoneNo: _phoneNo);
                  },
                  child: Text(
                    'Get OTP',
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
