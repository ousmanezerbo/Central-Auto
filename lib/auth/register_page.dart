// ignore_for_file: deprecated_member_use

import 'package:central_auto/auth/services/tests.dart';
import 'package:central_auto/home.dart';
import 'package:central_auto/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:string_validator/string_validator.dart';
/* import 'package:studi_kasus/widgets/custom_checkbox.dart';
import 'package:studi_kasus/widgets/primary_button.dart'; */
import '../share/loading.dart';
import 'login_page.dart';
import 'theme.dart';

import 'dart:async';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String get image => '';
  bool loadingg = false;

  void inscription() async {
    if (keys.currentState!.validate()) {
      print("$email $pass");
      setState(() {
        loadingg = true;
      });

      bool register =
          await auth.signup(email, pass, nom, prenom, numero, image);
      if (register == false) {
        setState(() {
          loadingg = false;
        });
      }

      if (register)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );

      print('Vérification effectuée mail');
    }
  }

  AuthServices auth = AuthServices();
  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  late String email, pass, cpass, nom, prenom, numero;
  final keys = GlobalKey<FormState>();
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  int currentStep = 0;
  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Etape 1'),
          content: Container(
            child: Column(
              children: [
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
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 8) {
                              return 'Numéro incorrect';
                            }
                            return null;
                          },
                          onChanged: (e) => numero = e,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Numéro',
                            prefixIcon: const Icon(Icons.phone_android),
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep > 1,
          title: Text('Etape 2'),
          content: Container(
            child: Column(
              children: [
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
              ],
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return loadingg
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
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
                          Image.asset('assets/images/logoCut.png'),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'S\'inscrire',
                            style: heading2.copyWith(color: textBlack),
                          ),
                          Image.asset(
                            'assets/images/accent.png',
                            width: 99,
                            height: 4,
                          ),
                          const SizedBox(
                            height: 10,
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
                                  style:
                                      regular16pt.copyWith(color: primaryBlue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stepper(
                        physics: const ClampingScrollPhysics(),
                        currentStep: currentStep,
                        steps: getSteps(),
                        onStepTapped: (index) {
                          setState(() {
                            currentStep = index;
                          });
                        },
                        onStepContinue: () async {
                          final isLastStep =
                              currentStep == getSteps().length - 1;
                          if (isLastStep) {
                            if (keys.currentState!.validate()) {
                              print("$email $pass");
                              setState(() {
                                loadingg = true;
                              });

                              bool register = await auth.signup(
                                  email, pass, nom, prenom, numero, image);
                              if (register == false) {
                                setState(() {
                                  loadingg = false;
                                });
                              }

                              if (register) {
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage()),
                                );
                              }

                              print('Vérification effectuée mail');
                            }
                          }
                          if (currentStep != 1) {
                            setState(() {
                              currentStep++;
                            });
                          }
                        },
                        onStepCancel: () {
                          if (currentStep != 0) {
                            setState(() {
                              currentStep--;
                            });
                          }
                        },
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          final isLastStep =
                              currentStep == getSteps().length - 1;
                          return Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Row(
                              children: [
                                if (currentStep != 0)
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: details.onStepCancel,
                                      child: const Text('Retour'),
                                    ),
                                  ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: details.onStepContinue,
                                    child: Text(
                                        isLastStep ? 'S\'inscrire' : 'Suivant'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      /* Form(
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
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 8) {
                                    return 'Numéro incorrect';
                                  }
                                  return null;
                                },
                                onChanged: (e) => numero = e,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Numéro',
                                  prefixIcon: const Icon(Icons.phone_android),
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
                                validator: (value) =>
                                    EmailValidator.validate(value!)
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
                        height: 10,
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
                      ), */
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
