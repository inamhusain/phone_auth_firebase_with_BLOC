// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyPhoneNo extends StatelessWidget {
  const VerifyPhoneNo({Key? key}) : super(key: key);

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
            MaterialButton(
              onPressed: () {},
              child: Text(
                'Verify',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              shape: StadiumBorder(),
              color: Colors.lightBlue,
            )
          ],
        ),
      ),
    );
  }
}
