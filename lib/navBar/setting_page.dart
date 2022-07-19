import 'package:flutter/material.dart';

import '../AuthSms/function.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            /* if (user != null) ...[
              Text("uid: " + user.uid),
            ], */
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
