import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:central_auto/model/cars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';

class CarDB {
  UploadTask? uploadTask;

  final CollectionReference CarCol =
      FirebaseFirestore.instance.collection("Cars");

  Future AddCar() async {}

  Future<String?> uploadImage(File file, {required String path}) async {
    var time = DateTime.now().toString();
    var ext = Path.basename(file.path).split(".")[1].toString();
    String image = path + "_" + time + "." + ext;
    try {
      final ref = FirebaseStorage.instance.ref().child(path + "/" + image);
      await ref.putFile(file);
      // await upload.onComplete;
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future saveCar(Car car) async {
    try {
      await CarCol.doc().set(car.toFirestore());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future deleteCar(String id) async {
    try {
      await CarCol.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future updateCar(Car car) async {
    try {
      await CarCol.doc(car.id).update(car.toFirestore());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<Car>> get getcar {
    return CarCol.snapshots().map((car) {
      return car.docs
          .map((e) => Car.fromJson(e.data() as Map<String, dynamic>, id: e.id))
          .toList();
    });
  }

  Stream<List<Car>> getCarfav() {
    final user = FirebaseAuth.instance.currentUser;
    return CarCol.where("Favoris", arrayContains: user!.uid)
        .snapshots()
        .map((vehicule) {
      return vehicule.docs
          .map((e) => Car.fromJson(e.data() as Map<String, dynamic>, id: e.id))
          .toList();
    });
  }
}
