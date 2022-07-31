import 'package:central_auto/auth/services/db.dart';
import 'package:central_auto/carClick.dart';
import 'package:central_auto/carScreen/carAdd.dart';
import 'package:central_auto/carScreen/listCars.dart';
import 'package:central_auto/model/cars.dart';
import 'package:central_auto/navBar/main_navigation.dart';
import 'package:central_auto/navBar/setting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AuthSms/function.dart';
import 'film/film.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

class MyAppHome extends StatelessWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //body: Text('Hello word'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Searchection(),
              carousel(),
            ],
          ),
        ));
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);
  const MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text('Central Auto'),
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => CarAdd()));
          /* Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return CarInformation();
              //const MyAppBarCar()
            },
            fullscreenDialog: true,
          )); */
        },
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchPage())),
            icon: const Icon(Icons.search))
      ],
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Recherche...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}

class Searchection extends StatefulWidget {
  const Searchection({Key? key}) : super(key: key);

  @override
  State<Searchection> createState() => _SearchectionState();
}

class _SearchectionState extends State<Searchection> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Cars');
  @override
  Widget build(BuildContext context) {
    return Container(
        /* 
      height: 100,
      color: Colors.grey[200],
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 35),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: 'Recherche',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(0, 4)),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                  child: const Icon(Icons.search),
                ),
              ),
            ],
          ),
        ],
      ), */
        );
  }
}

// ignore: camel_case_types
class carousel extends StatefulWidget {
  carousel({Key? key}) : super(key: key);

  @override
  State<carousel> createState() => _carouselState();
}

// ignore: camel_case_types
class _carouselState extends State<carousel> {
  List<CarouselItem> itemList = [
    CarouselItem(
      image: const NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/centralauto-39f3e.appspot.com/o/images%2FIMG_3617.jpg?alt=media&token=04d2606b-7a6c-40a1-9949-e6e63884ea1d',
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title: ' Toyota Corola',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '2016',
      rightSubtitle: '6000000 Fcfa',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/centralauto-39f3e.appspot.com/o/images%2Fe1.jpg?alt=media&token=6802abaf-c0ca-4276-be75-eabf4aee6682',
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title: 'Toyota Corola',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '2020',
      rightSubtitle: '15000000 Fcfa',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/centralauto-39f3e.appspot.com/o/images%2Fg1.jpg?alt=media&token=c09b1441-931b-44b9-a2d1-2ede39473563',
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title: 'Mercedes Class - G',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '2019',
      rightSubtitle: '600000000 Fcfa',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      onImageTap: (i) {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    //final List<Car> cars = Provider.of<List<Car>>(context);
    // print(cars);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                Image.asset('assets/images/logoCut.png'),
                const SizedBox(height: 50),
                CustomCarouselSlider(
                  items: itemList,
                  height: 260,
                  subHeight: 50,
                  width: MediaQuery.of(context).size.width * .9,
                  autoplay: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
