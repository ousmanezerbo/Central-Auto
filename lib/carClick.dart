import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class caClick extends StatefulWidget {
  const caClick({Key? key}) : super(key: key);

  @override
  State<caClick> createState() => _caClickState();
}

class _caClickState extends State<caClick> {
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

        return SingleChildScrollView(
          child: Container(
            color: Colors.red[100],
            height: 400,
          ),
        );
      },
    );
  }
}
