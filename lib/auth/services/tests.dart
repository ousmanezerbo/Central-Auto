import 'package:central_auto/auth/model/utilisateur.dart';
import 'package:central_auto/auth/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  get currentUser => null;

  Future<bool> signup(
      String email, String pass, String nom, String prenom) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (result.user != null) {
        await DBServices().saveUser(UserM(
            id: result.user!.uid, email: email, nom: nom, prenom: prenom));
        return true;
      }
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

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Utilisateurs').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['nom']),
              subtitle: Text(data['prenom']),
            );
          }).toList(),
        );
      },
    );
  }
}
