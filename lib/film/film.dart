import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_movie_page.dart';

class MyAppBarCar extends StatefulWidget {
  const MyAppBarCar({Key? key}) : super(key: key);

  @override
  State<MyAppBarCar> createState() => _MyAppBarCarState();
}

class _MyAppBarCarState extends State<MyAppBarCar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const AppBarCar(),
    );
  }
}

class AppBarCar extends StatelessWidget {
  const AppBarCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: CarInformation(),
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
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Center(),
                  SizedBox(
                    width: 200,
                    /* height: 200, */
                    child: Image.network(
                      data['Image'],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
