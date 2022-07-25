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
    return Scaffold(
      appBar: AppBar(title: Text('Détails de la voiture')),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
