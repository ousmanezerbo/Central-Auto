import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:studi_kasus/login_page.dart';
import 'login_page.dart';

class MyAppAuth extends StatelessWidget {
  const MyAppAuth({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
