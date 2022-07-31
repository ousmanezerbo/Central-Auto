import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

typedef CarPressedCallback = void Function(Car car);

typedef CloseCarPressedCallback = void Function();

class Car {
  String? id;
  String? uid;
  String? Marque;
  String? Model;
  String? Prix;
  String? Annee;
  List<String>? images;
  String? Puissance;
  String? Kilometre;
  String? Nbporte;
  String? Etat;
  String? Carosserie;
  String? Carburant;
  String? Transmission;
  String? Detailsup;

  Car({
    this.id,
    this.uid,
    this.Marque,
    this.Model,
    this.Prix,
    this.Annee,
    this.images,
    this.Puissance,
    this.Kilometre,
    this.Nbporte,
    this.Etat,
    this.Carosserie,
    this.Carburant,
    this.Transmission,
    this.Detailsup,
  });

  factory Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Car(
      id: snapshot.id,
      uid: data?['uid'],
      Marque: data?['Marque'],
      Model: data?['Model'],
      Prix: data?['Prix'],
      Annee: data?['Annee'],
      images: data?['images'] is Iterable ? List.from(data?['images']) : null,
      Puissance: data?['Puissance'],
      Kilometre: data?['Kilometre'],
      Nbporte: data?['Nbporte'],
      Etat: data?['Etat'],
      Carosserie: data?['Carosserie'],
      Carburant: data?['Carburant'],
      Transmission: data?['Transmission'],
      Detailsup: data?['Detailsup'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) 'uid': uid,
      if (Marque != null) 'Marque': Marque,
      if (Model != null) 'Model': Model,
      if (Prix != null) 'Prix': Prix,
      if (Annee != null) 'Annee': Annee,
      if (images != null) 'images': images,
      if (Puissance != null) 'Puissance': Puissance,
      if (Kilometre != null) 'Kilometre': Kilometre,
      if (Nbporte != null) 'Nbporte': Nbporte,
      if (Etat != null) 'Etat': Etat,
      if (Carosserie != null) 'Carosserie': Carosserie,
      if (Carburant != null) 'Carburant': Carburant,
      if (Transmission != null) 'Transmission': Transmission,
      if (Detailsup != null) 'Detailsup': Detailsup,
    };
  }

  factory Car.fromJson(Map<String, dynamic> map, {String? id}) => Car(
        id: id,
        uid: map["uid"],
        Marque: map["Marque"],
        Model: map["Model"],
        Prix: map["Prix"],
        Annee: map["Annee"],
        images: map["images"].map<String>((i) => i as String).toList(),
        Puissance: map["Puissance"],
        Kilometre: map["Kilometre"],
        Nbporte: map["Nbporte"],
        Etat: map["Etat"],
        Carosserie: map["Carosserie"],
        Carburant: map["Carburant"],
        Transmission: map["Transmission"],
        Detailsup: map["Detailsup"],
      );
}

/* factory Car.fromSnapshot(DocumentSnapshot snapshot) {
    final _snapshot = snapshot.data() as Map<String, dynamic>;
    return Car(
      id: snapshot.id,
      Marque: _snapshot['Marque'],
      Model: _snapshot['Model'],
      Prix: _snapshot['Prix'],
      Annee: _snapshot['Annee'],
      uid: _snapshot['udi'],
      images: _snapshot['images'],
    );
  } */
