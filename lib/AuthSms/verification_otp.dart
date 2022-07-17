import 'package:central_auto/home.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class verificationOtp extends StatefulWidget {
  const verificationOtp({Key? key}) : super(key: key);

  @override
  State<verificationOtp> createState() => _verificationOtpState();
}

class _verificationOtpState extends State<verificationOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: (Column(
          children: [
            const Text(
              'Verification Otp',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
            const Text(
              'Check your messages to validate',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Pinput(
              length: 6,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: const Text('Resend de code'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15)),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (c) => const MyAppHome()));
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )
          ],
        )),
      )),
    );
  }
}
