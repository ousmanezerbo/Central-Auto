import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Car {
  String? Marque;
  String? Model;
  String? Prix;
  String? Annee;
  String? Image;
  List<String>? images;

  Car(
      {this.Marque,
      this.Model,
      this.Prix,
      this.Annee,
      this.Image,
      this.images});

  factory Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Car(
      Marque: data?['Marque'],
      Model: data?['Model'],
      Prix: data?['Prix'],
      Annee: data?['Annee'],
      Image: data?['Image'],
      images: data?['images'] is Iterable ? List.from(data?['images']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (Marque != null) 'Marque': Marque,
      if (Model != null) 'Model': Model,
      if (Prix != null) 'Prix': Prix,
      if (Annee != null) 'Annee': Annee,
      if (Image != null) 'Image': Image,
      if (images != null) 'images': images,
    };
  }
}
