import 'package:central_auto/auth/services/db.dart';
import 'package:central_auto/film/add_movie_page.dart';
import 'package:central_auto/home.dart';
import 'package:central_auto/model/cars.dart';
import 'package:central_auto/navBar/car_page.dart';
//import 'package:central_auto/nouveau/homeCar.dart';
import 'package:central_auto/settingUser/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:central_auto/carScreen/listCars.dart';
import 'package:central_auto/model/bdcars.dart';

import '../auth/register_page.dart';
import 'setting_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedPage = 0;
  final pages = [
    const MyAppHome(),
    //carPage(),

    //const AppPage(),
    StreamProvider<List<Car>>.value(
      value: DBServices().getcar,
      initialData: const [],
      child: const listCar(),
    ),
    const RegisterPage(),
    //HomePagess(),
    //const SettingPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pages[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedPage,
          fixedColor: Colors.blueAccent,
          unselectedItemColor: const Color(0xFF757575),
          onTap: (position) {
            setState(() {
              selectedPage = position;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Acceuil"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.car), label: "Voitures"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favoris"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ]),
    );
  }
}
