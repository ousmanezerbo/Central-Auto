import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/utilisateur.dart';

class DBServices {
  final CollectionReference usercol =
      FirebaseFirestore.instance.collection("Utilisateurs");

  final CollectionReference voitureCol =
      FirebaseFirestore.instance.collection("Voitures");

  Future saveUser(UserM user) async {
    try {
      await usercol.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getUser(String id) async {
    try {
      final data = await usercol.doc(id).get();
      final user = UserM.fromJson(data.data() as Map<String, dynamic>);
      return user;
    } catch (e) {
      return false;
    }
  }

  Future updateUser(UserM user) async {
    try {
      await usercol.doc(user.id).update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<UserM>? get getCurrentUser {
    final user = FirebaseAuth.instance.currentUser;
    return user != null
        ? usercol.doc(user.uid).snapshots().map((user) {
            UserM.currentUser =
                UserM.fromJson(user.data() as Map<String, dynamic>);
            return UserM.fromJson(user.data() as Map<String, dynamic>);
          })
        : null;
  }
}
