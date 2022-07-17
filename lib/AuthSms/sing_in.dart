import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'verification_otp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              IntlPhoneField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => const verificationOtp()));
                    },
                    child: const Text(
                      'Sing In ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
