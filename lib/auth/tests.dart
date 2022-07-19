import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

/* Future<User?> get user async {
  final user = FirebaseAuth.instance.currentUser;
  return user;
} */

/* Future<bool> signup(String email, String pass) async {
  try {
    final result =
        await auth.createUserWithEmailAndPassword(email: email, password: pass);
    if (result.user != null) return true;
    return false;
  } catch (e) {
    return false;
  }
} */

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signup(String email, String pass) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (result.user != null) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signin(String email, String pass) async {
    try {
      final result =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (result.user != null) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<User?> get user async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }
}

Future<User?> get user async {
  final user = FirebaseAuth.instance.currentUser;
  return user;
}
