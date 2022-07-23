import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../film/add_movie_page.dart';
import '../home.dart';

class carPage extends StatefulWidget {
  const carPage({Key? key}) : super(key: key);

  @override
  State<carPage> createState() => _carPageState();
}

class _carPageState extends State<carPage> {
  @override
  Widget build(BuildContext context) {
    return const MyAppBarCar();
  }
}

class MyAppBarCar extends StatefulWidget {
  const MyAppBarCar({Key? key}) : super(key: key);

  @override
  State<MyAppBarCar> createState() => _MyAppBarCarState();
}

class _MyAppBarCarState extends State<MyAppBarCar> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppBarCar(),
    );
  }
}

class AppBarCar extends StatelessWidget {
  const AppBarCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Center(
          child: Text('Central Auto'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return const AppPage();
              },
              fullscreenDialog: true,
            ));
          },
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search))
        ],
      ),
      body: CarInformation(),
      //appBar: const MyAppBar(),
    );
  }
}

class CarInformation extends StatefulWidget {
  @override
  _CarInformationState createState() => _CarInformationState();
}

class _CarInformationState extends State<CarInformation> {
  final Stream<QuerySnapshot> _carStream =
      FirebaseFirestore.instance.collection('Cars').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _carStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.blue,
              strokeWidth: 5,
            ),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 200, 209, 218),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Column(
                children: [
                  Container(
                    height: 248,
                    //color: Colors.amber,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(data['Image']),
                          fit: BoxFit.cover),
                    ),
                    child: Stack(children: [
                      Positioned(
                          top: 10,
                          right: -10,
                          child: MaterialButton(
                              color: Colors.white,
                              shape: CircleBorder(),
                              onPressed: () {},
                              child: Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.lightBlue,
                                size: 20,
                              )))
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data['Marque'],
                          style: GoogleFonts.nunito(
                              fontSize: 11, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data['Model'],
                          style: GoogleFonts.nunito(
                              fontSize: 11, fontWeight: FontWeight.w800),
                        ),
                        /* SizedBox(
                          width: 81,
                        ), */
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data['Annee'],
                          style: GoogleFonts.nunito(
                              fontSize: 9, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          data['Prix'] + " Fcfa",
                          style: GoogleFonts.nunito(
                              fontSize: 11, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
