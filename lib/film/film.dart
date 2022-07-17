import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_movie_page.dart';

class AppBarfilm extends StatelessWidget {
  const AppBarfilm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Central Auto'),
        ),
        leading: IconButton(
          icon: Icon(Icons.add),
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
      body: MoviesInformation(),
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
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Center(),
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
