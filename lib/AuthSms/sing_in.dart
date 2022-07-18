import 'package:central_auto/AuthSms/function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'verification_otp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;

  String phoneNumber = '';
  void SendOtpCode() {
    loading = true;
    setState(() {});
    final auth = FirebaseAuth.instance;
    if (phoneNumber.isNotEmpty) {
      authWithPhoneNumber(
        phoneNumber,
        onCodeSend: (verificationId, v) {
          loading = false;
          setState(() {});
          Navigator.of(context).push(MaterialPageRoute(
              builder: (c) => verificationOtp(
                    verificationId: verificationId,
                    phoneNumber: phoneNumber,
                  )));
        },
        onAutoVerify: (v) async {
          await auth.signInWithCredential(v);
        },
        onFailed: (e) {
          print('Le code eroneee');
        },
        autoRetrieval: (v) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 223, 209, 209),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Inscription',
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/accent.png',
                    width: 99,
                    height: 4,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              /* const Text(
                'Entrez votre numéro de téléphone',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ), */
              const SizedBox(
                height: 20,
              ),
              IntlPhoneField(
                initialCountryCode: 'ML',
                onChanged: (value) {
                  phoneNumber = value.completeNumber;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: 'Numéro',
                  border: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      ),
                ),
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
                    onPressed: loading ? null : SendOtpCode,
                    child: loading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : const Text(
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
