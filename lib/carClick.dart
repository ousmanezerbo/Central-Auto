import 'package:central_auto/model/cars.dart';
import 'package:central_auto/model/bdcars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class carClick extends StatelessWidget {
  final Car car;
  carClick({Key? key, required this.car}) : super(key: key);
  /* final Stream<QuerySnapshot> _carStream =
      FirebaseFirestore.instance.collection('Cars').snapshots(); */

  @override
  Widget build(BuildContext context) {
    return Text('Oupps');
    /* return StreamBuilder<QuerySnapshot>(
      stream: _carStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['Marque']),
                  subtitle: Text(data['Model']),
                );
              })
              .toList()
              .cast(),
        );
      },
    ); */
  }
  /* Scaffold(
      appBar: AppBar(title: Text('Détails du véhichule')),
      body: SingleChildScrollView(
        child: Column(
          children: [Text('')],
        ),
      ),
    ); */
}
