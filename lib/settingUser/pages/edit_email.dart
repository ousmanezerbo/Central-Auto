import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

//import '../user/user_data.dart';
import '../widgets/appbar_widget.dart';
import '../../auth/model/utilisateur.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  // var user = UserData.myUser;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  //  void updateUserValue(String email) {
  //    user.email = email;
  //  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Utilisateurs');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(user?.uid).snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          return Scaffold(
            appBar: buildAppBar(context),
            body: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                          width: 320,
                          child: Text(
                            "Entrez votre nouvelle adresse email.",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: SizedBox(
                              height: 100,
                              width: 320,
                              child: TextFormField(
                                // Handles Form Validation
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un email';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Votre email'),
                                controller: emailController,
                              ))),
                      Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 320,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate() &&
                                    EmailValidator.validate(
                                        emailController.text)) {
                                  //updateUserValue(emailController.text);
                                  user?.updateEmail(emailController.text);
                                  usersCollection
                                      .doc(user?.uid)
                                      .update({'email': emailController.text})
                                      .then((_) => print('mis à jour'))
                                      .catchError((error) =>
                                          print('Update failed: $error'));
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Mettre à jour',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
