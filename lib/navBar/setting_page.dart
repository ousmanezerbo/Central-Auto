import 'package:central_auto/auth/model/utilisateur.dart';
import 'package:central_auto/auth/services/tests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/services/db.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UserM? userm;
  AuthServices auth = AuthServices();
  // final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getUser() async {
    /*  final User userm = auth.currentUser;
    final uid = userm.uid; */
    User? user = await auth.user;
    final userResult = await DBServices().getUser(user!.uid);
    setState(() {
      userm = userResult;
      UserM.currentUser = userResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = UserM.currentUser;
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text(user!.email),
          accountName: Text(user.nom),
        ),
      ],
    );

    /* Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await deconnection();
              },
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              child: const Icon(Icons.logout),
            ),
            const Text(
              "Se déconnecter",
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.center,
            ),
            // ignore: unnecessary_null_comparison
            if (userm != null) ...[
              Text("id: ${userm?.id}"),
            ],
            const SizedBox(
              height: 20,
            ),
            Text('email: ${userm?.email}')
          ],
        ),
      ),
    ); */
  }
}
