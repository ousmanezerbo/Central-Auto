import 'dart:io';

import 'package:central_auto/model/bdcars.dart';
import 'package:central_auto/model/cars.dart';
import 'package:central_auto/share/getImage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect/multiselect.dart';
import 'package:get/get.dart';

import '../share/loading.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text('Ajouter une voiture'),
        centerTitle: true,
      ), */
      body: AddPage(),
    );
  }
}

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final key = GlobalKey<FormState>();
  final MarqueController = TextEditingController();
  final ModelController = TextEditingController();
  final AnneeController = TextEditingController();
  final PrixController = TextEditingController();
  final ImageController = TextEditingController();
  List<File> images = [];
  bool loadingg = false;
  List<String> Categories = [];
  late String Marque, Model, Annee, Prix;
  Car car = Car();

  @override
  Widget build(BuildContext context) {
    return loadingg
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Form(
                  key: key,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 60,
                        color: Colors.blue,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(
                          child: Text(
                            'Entrez les informations du vehicule',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrez la marque de la voiture';
                            }
                            return null;
                          },
                          onChanged: (e) => Marque = e,
                          decoration: const InputDecoration(
                            hintText: 'Marque de la voiture',
                            labelText: 'Marque :',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrez le modèle de la voiture';
                            }
                            return null;
                          },
                          onChanged: (e) => Model = e,
                          decoration: const InputDecoration(
                            hintText: 'Modèle de la voiture',
                            labelText: 'Modèle :',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrez l\'anneé de la voiture';
                            }
                            return null;
                          },
                          onChanged: (e) => Annee = e,
                          decoration: const InputDecoration(
                            hintText: 'Anneé de la voiture',
                            labelText: 'Année :',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrez le prix de la voiture';
                            }
                            return null;
                          },
                          onChanged: (e) => Prix = e,
                          decoration: const InputDecoration(
                            hintText: 'Prix de la voiture',
                            labelText: 'Prix :',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () async {
                                final data = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return GetImage();
                                    });

                                if (data != null) {
                                  setState(() {
                                    images.add(data);
                                  });
                                }
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                color: Colors.blue,
                                child: Icon(
                                  FontAwesomeIcons.plusCircle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            for (int i = 0; i < images.length; i++)
                              Container(
                                //color: Colors.amber,
                                margin: EdgeInsets.only(right: 3, left: 3),
                                height: 100,
                                width: 70,
                                child: Stack(
                                  children: [
                                    Image.file(
                                      images[i],
                                      height: 80,
                                      width: 100,
                                      alignment: Alignment.center,
                                    ),
                                    Align(
                                      //alignment: Alignment.center,
                                      child: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.minusCircle,
                                          color: Colors.red,
                                        ),
                                        alignment: Alignment.bottomRight,
                                        onPressed: () {
                                          setState(() {
                                            images.removeAt(i);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          height: 50,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Colors.blue,
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              setState(() {
                                loadingg = true;
                              });
                              car.Marque = Marque;
                              car.Model = Model;
                              car.Prix = Prix;
                              car.Annee = Annee;
                              car.images = [];
                              for (var i = 0; i < images.length; i++) {
                                String? urlImage = await CarDB()
                                    .uploadImage(images[i], path: 'car');
                                if (urlImage != null) {
                                  car.images!.add(urlImage);
                                }
                                if (images.length == car.images!.length) {
                                  bool save = await CarDB().saveCar(car);
                                  if (save) {
                                    setState(() {
                                      loadingg = false;
                                    });
                                  } else
                                    (loadingg = false);
                                  Navigator.of(context).pop();
                                }
                              }
                            }
                          },
                          child: Text(
                            'Enregistrer',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
