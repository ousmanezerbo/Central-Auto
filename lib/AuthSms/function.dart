import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
void authWithPhoneNumber(String phone,
    {required Function(String value, int? value1) onCodeSend,
    required Function(PhoneAuthCredential value) onAutoVerify,
    required Function(FirebaseAuthException value) onFailed,
    required Function(String value) autoRetrieval}) async {
  _auth.verifyPhoneNumber(
    phoneNumber: phone,
    timeout: Duration(seconds: 50),
    verificationCompleted: onAutoVerify,
    verificationFailed: onFailed,
    codeSent: onCodeSend,
    codeAutoRetrievalTimeout: autoRetrieval,
  );
}

Future<void> validateOpt(String smsCode, String verificationId) async {
  final _credential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: smsCode);
  await _auth.signInWithCredential(_credential);
  return;
}

Future<void> deconnection() async {
  await _auth.signOut();
  return;
}
