import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return const MyAppBarFilm();
  }
}

class MyAppBarFilm extends StatefulWidget {
  const MyAppBarFilm({Key? key}) : super(key: key);

  @override
  State<MyAppBarFilm> createState() => _MyAppBarFilmState();
}

class _MyAppBarFilmState extends State<MyAppBarFilm> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppBarfilm(),
    );
  }
}

class AppBarfilm extends StatelessWidget {
  const AppBarfilm({Key? key}) : super(key: key);

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
      body: MoviesInformation(),
      //appBar: const MyAppBar(),
    );
  }
}

class MoviesInformation extends StatefulWidget {
  @override
  _MoviesInformationState createState() => _MoviesInformationState();
}

class _MoviesInformationState extends State<MoviesInformation> {
  final Stream<QuerySnapshot> _movieStream =
      FirebaseFirestore.instance.collection('Movies').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _movieStream,
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
                      data['poster'],
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
