import 'dart:async';

import 'package:central_auto/AuthSms/function.dart';
import 'package:central_auto/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pinput/pinput.dart';

class verificationOtp extends StatefulWidget {
  const verificationOtp(
      {Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);
  final String verificationId;
  final String phoneNumber;

  @override
  State<verificationOtp> createState() => _verificationOtpState();
}

class _verificationOtpState extends State<verificationOtp> {
  String smsCode = "";
  bool loading = false;
  bool resend = false;
  int count = 50;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decompte();
  }

  late Timer timer;
  void decompte() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (count < 1) {
        timer.cancel();
        count = 50;
        resend = true;
        setState(() {});
        return;
      }
      count--;
      setState(() {});
    });
  }

  void onResendSmsCode() {
    resend = false;
    setState(() {});
    authWithPhoneNumber(
      widget.phoneNumber,
      onCodeSend: (verificationId, v) {
        loading = false;
        decompte();
        setState(() {});
      },
      onAutoVerify: (v) async {
        await _auth.signInWithCredential(v);
      },
      onFailed: (e) {
        print('Le code eroneee');
      },
      autoRetrieval: (v) {},
    );
  }

  void onVerifySmsCode() async {
    loading = true;
    setState(() {});
    await validateOpt(smsCode, widget.verificationId);
    loading = true;
    setState(() {});
    Navigator.of(context).pop();
    print('Vérification effectuée');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: (Column(
                children: [
                  const Text(
                    'Entrez le code de validation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Vérifiez vos SMS',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    length: 6,
                    onChanged: (value) {
                      smsCode = value;
                      setState(() {});
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: !resend ? null : onResendSmsCode,
                      child: Text(!resend
                          ? '00:${count.toString().padLeft(2, '0')}'
                          : 'Renvoyer le code'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15)),
                        onPressed: smsCode.length < 6 || loading
                            ? null
                            : onVerifySmsCode,
                        child: loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Verifer',
                                style: TextStyle(fontSize: 20),
                              ),
                      )
                    ],
                  )
                ],
              )),
            ),
          )),
    );
  }
}
