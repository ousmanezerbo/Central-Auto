import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../user/user_data.dart';
import '../widgets/appbar_widget.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  //var user = UserData.myUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Utilisateurs');

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  // void updateUserValue(String name) {
  //   user.name = name;
  // }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                    width: 330,
                    child: const Text(
                      "Entrez votre nom et prénom",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 150,
                            child: TextFormField(
                              // Handles Form Validation for First Name
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrez votre nom';
                                } else if (!isAlpha(value)) {
                                  return 'Uniquement des lettres';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Nom'),
                              controller: firstNameController,
                            ))),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 150,
                            child: TextFormField(
                              // Handles Form Validation for Last Name
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrez votre prénom';
                                } else if (!isAlpha(value)) {
                                  return 'Uniquement des lettres';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Prénom'),
                              controller: secondNameController,
                            )))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate() &&
                                  isAlpha(firstNameController.text +
                                      secondNameController.text)) {
                                usersCollection
                                    .doc(user?.uid)
                                    .update({'nom': firstNameController.text})
                                    .then((_) => print('mis à jour'))
                                    .catchError((error) =>
                                        print('Update failed: $error'));
                                usersCollection
                                    .doc(user?.uid)
                                    .update(
                                        {'prenom': secondNameController.text})
                                    .then((_) => print('mis à jour'))
                                    .catchError((error) =>
                                        print('Update failed: $error'));
                                /*  updateUserValue(firstNameController.text +
                                  " " +
                                  secondNameController.text); */
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Mettre à jour',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ],
            ),
          )),
        ));
  }
}
