// ignore_for_file: deprecated_member_use

import 'package:central_auto/auth/services/tests.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
/* import 'package:studi_kasus/widgets/custom_checkbox.dart';
import 'package:studi_kasus/widgets/primary_button.dart'; */
import 'login_page.dart';
import 'theme.dart';

import 'dart:async';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void inscription() async {
    if (keys.currentState!.validate()) {
      print("$email $pass");

      bool register = await auth.signup(email, pass, nom, prenom);

      if (register) Navigator.of(context).maybePop();

      print('Vérification effectuée mail');
    }
  }

  AuthServices auth = AuthServices();
  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  late String email, pass, cpass, nom, prenom;
  final keys = GlobalKey<FormState>();
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: /* SafeArea */ WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'S\'inscrire',
                      style: heading2.copyWith(color: textBlack),
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
                Form(
                  key: keys,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrez votre prénom';
                            }
                            return null;
                          },
                          onChanged: (e) => prenom = e,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Prénom',
                            prefixIcon: const Icon(Icons.person),
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrez votre nom';
                            }
                            return null;
                          },
                          onChanged: (e) => nom = e,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Nom',
                            prefixIcon: const Icon(Icons.person),
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Entrez un email",
                          onChanged: (e) => email = e,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            hintText: 'Email',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Veuillez saisir un mot de passe';
                            }
                            if (value.isEmpty) {
                              return 'Veuillez saisir un mot de passe';
                            }
                            if (value.length < 6) {
                              return 'Mot de passe minimum : 6 \ncaractères';
                            }

                            return null;
                          },
                          onChanged: (e) => pass = e,
                          maxLines: 1,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Mot de passe',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value ==
                                    null /* ||
                                value.isEmpty ||
                                value.length < 6 ||
                                value != pass */
                                ) {
                              return 'Veuillez saisir un mot de passe';
                            }
                            if (value.isEmpty) {
                              return 'Veuillez saisir un mot de passe';
                            }
                            if (value.length < 6) {
                              return 'Mot de passe minimum : 6 \ncaractères';
                            }
                            if (value != pass) {
                              return 'Entrez le même mot de passe';
                            }
                            return null;
                          },
                          onChanged: (e) => cpass = e,
                          maxLines: 1,
                          obscureText: !passwordConfrimationVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Confirmer le mot de passe',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordConfrimationVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  passwordConfrimationVisible =
                                      !passwordConfrimationVisible;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      /*        RaisedButton(
                      color: primaryBlue,
                      padding: const EdgeInsets.all(10),
                      onPressed: () {},
                      child: const Text('Inscription'),
                    ), */
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [],
                ),

                /* CustomPrimaryButton(
                buttonColor: primaryBlue,
                textValue: 'Inscription',
                textColor: Colors.white,
              ),
              const SizedBox(
                height: 30,
              ), */
                Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(14.0),
                      elevation: 0,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              inscription();
                            },
                            borderRadius: BorderRadius.circular(14.0),
                            child: Center(
                              child: Text(
                                'Inscription',
                                style: heading5.copyWith(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Un compte? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Se connecter',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> signup(String email, String pass) async {
  try {
    final result =
        await auth.createUserWithEmailAndPassword(email: email, password: pass);
    if (result.user != null) return true;
    return false;
  } catch (e) {
    return false;
  }
}
