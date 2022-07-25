import 'dart:io';
import 'dart:ui';
import 'package:central_auto/model/cars.dart';
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
}
