// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:central_auto/model/bdcars.dart';
import 'package:central_auto/model/cars.dart';
import 'package:central_auto/share/getImage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../share/loading.dart';

class CarUpdate extends StatefulWidget {
  Car? car;
  CarUpdate({Key? key, this.car}) : super(key: key);

  @override
  State<CarUpdate> createState() => _CarUpdateState();
}

class _CarUpdateState extends State<CarUpdate> {
  // List<dynamic> imagess = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Marque = widget.car!.Marque.toString();
    Model = widget.car!.Model.toString();
    Annee = widget.car!.Annee.toString();
    Etat = widget.car!.Etat.toString();
    Puissance = widget.car!.Puissance.toString();
    Kilometre = widget.car!.Kilometre.toString();
    Transmission = widget.car!.Transmission.toString();
    Carburant = widget.car!.Carburant.toString();
    Nbporte = widget.car!.Nbporte.toString();
    Carosserie = widget.car!.Carosserie.toString();
    Prix = widget.car!.Prix.toString();
    Detailsup = widget.car!.Detailsup.toString();
    //  imagess = widget.car!.images!;
    //images = widget.car!.images!;
    images.addAll(widget.car!.images!);
    car = widget.car!;
  }

  int currentStep = 0;
  final key = GlobalKey<FormState>();
  List<dynamic> images = [];
  bool loadingg = false;

  String Marque = '',
      Model = '',
      Annee = '',
      Prix = '',
      Puissance = '',
      Kilometre = '',
      Nbporte = '',
      Etat = '',
      Carosserie = '',
      Carburant = '',
      Transmission = '',
      Detailsup = '';
  Car car = Car();

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Etape 1'),
          content: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  initialValue: Marque,
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
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: Model,
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
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: Annee,
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
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: Etat,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez l\'état de la voiture';
                    }
                    return null;
                  },
                  onChanged: (e) => Etat = e,
                  decoration: const InputDecoration(
                    hintText: 'État de la voiture',
                    labelText: 'État :',
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Etape 2'),
          content: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  initialValue: Puissance,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez la puissance de la voiture';
                    }
                    return null;
                  },
                  onChanged: (e) => Puissance = e,
                  decoration: const InputDecoration(
                    hintText: 'Ex : 125ch',
                    labelText: 'Puissance :',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: Kilometre,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez le kilométrage de la voiture';
                    }
                    return null;
                  },
                  onChanged: (e) => Kilometre = e,
                  decoration: const InputDecoration(
                    hintText: 'Kilométrage de la voiture',
                    labelText: 'Kilométrage :',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: Transmission,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez le type de transmission de la voiture';
                    }
                    return null;
                  },
                  onChanged: (e) => Transmission = e,
                  decoration: const InputDecoration(
                    hintText: 'Transmission de la voiture',
                    labelText: 'Transmission :',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: Carburant,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez le type de carburant de la voiture';
                    }
                    return null;
                  },
                  onChanged: (e) => Carburant = e,
                  decoration: const InputDecoration(
                    hintText: 'Type de carburant de la voiture',
                    labelText: 'Carburant :',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Etape 3'),
          content: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: Nbporte,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez le nombre de porte de la voiture';
                          }
                          return null;
                        },
                        onChanged: (e) => Nbporte = e,
                        decoration: const InputDecoration(
                          hintText: 'Nombre de porte de la voiture',
                          labelText: 'Nombre de porte :',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        initialValue: Carosserie,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez le type de chassi de la voiture';
                          }
                          return null;
                        },
                        onChanged: (e) => Carosserie = e,
                        decoration: const InputDecoration(
                          hintText: 'Ex: 4X4, berline...',
                          labelText: 'Chassi :',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        initialValue: Prix,
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
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        initialValue: Detailsup,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez des détails supplémentaires sur la voiture';
                          }
                          return null;
                        },
                        onChanged: (e) => Detailsup = e,
                        decoration: const InputDecoration(
                          hintText: 'Détails supplémentaires de la voiture',
                          labelText: 'Détails supplémentaires :',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                                child: const Icon(
                                  FontAwesomeIcons.plusCircle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            for (int i = 0; i < images.length; i++)
                              Container(
                                //color: Colors.amber,
                                margin:
                                    const EdgeInsets.only(right: 3, left: 3),
                                height: 100,
                                width: 70,
                                child: Stack(
                                  children: [
                                    if (images[i] is File)
                                      Image.file(
                                        images[i],
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 100,
                                        alignment: Alignment.center,
                                      )
                                    else
                                      Image.network(
                                        images[i],
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 100,
                                        alignment: Alignment.center,
                                      ),
                                    Align(
                                      //alignment: Alignment.center,
                                      child: IconButton(
                                        icon: const Icon(
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 3,
          title: Text('Etape 4'),
          content: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*  if (Marque != null)
                  Text('Marque: ${Marque}')
                else */

                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Marque: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Marque)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Modèle: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Model)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Année: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Annee)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'État: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Etat)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Puissance: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Puissance)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Kilométrage: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Kilometre)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Transmission: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Transmission)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Carburant: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Carburant)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Nombre de porte: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Nbporte)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Chassi: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Carosserie)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Prix: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Prix)
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '',
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Détails supplémentaires: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextSpan(text: Detailsup)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return loadingg
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title:
                  Text('Modifier ${widget.car!.Marque} ${widget.car!.Model}'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Stepper(
                physics: const ClampingScrollPhysics(),
                currentStep: currentStep,
                steps: getSteps(),
                onStepTapped: (index) {
                  setState(() {
                    currentStep = index;
                  });
                },
                onStepContinue: () async {
                  final isLastStep = currentStep == getSteps().length - 1;
                  if (isLastStep) {
                    if (key.currentState!.validate() && images.isNotEmpty) {
                      setState(() {
                        loadingg = true;
                      });
                      car.Marque = Marque;
                      car.Model = Model;
                      car.Prix = Prix;
                      car.Annee = Annee;
                      car.uid = FirebaseAuth.instance.currentUser?.uid;
                      car.images = [];
                      car.Kilometre = Kilometre;
                      car.Puissance = Puissance;
                      car.Nbporte = Nbporte;
                      car.Etat = Etat;
                      car.Carosserie = Carosserie;
                      car.Carburant = Carburant;
                      car.Transmission = Transmission;
                      car.Detailsup = Detailsup;
                      for (var i = 0; i < images.length; i++) {
                        if (images[i] is File) {
                          String? urlImage =
                              await CarDB().uploadImage(images[i], path: 'car');
                          if (urlImage != null) {
                            car.images!.add(urlImage);
                          }
                        } else {
                          car.images!.add(images[i]);
                        }
                        if (images.length == car.images!.length) {
                          bool update = await CarDB().updateCar(car) as bool;
                          if (update) {
                            setState(() {
                              loadingg = false;
                            });
                          } else
                            (loadingg = false);
                          Navigator.of(context).pop();
                          const text = "La modification à bien été effectuée";
                          final snackBar = SnackBar(
                            content: Text(text),
                            duration: Duration(minutes: 60),
                            action: SnackBarAction(
                                label: 'D\'accord', onPressed: () {}),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    }
                  }
                  if (currentStep != 3) {
                    setState(() {
                      currentStep++;
                    });
                  }
                },
                onStepCancel: () {
                  if (currentStep != 0) {
                    setState(() {
                      currentStep--;
                    });
                  }
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  final isLastStep = currentStep == getSteps().length - 1;
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        if (currentStep != 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: details.onStepCancel,
                              child: const Text('Précédent'),
                            ),
                          ),
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: Text(isLastStep ? 'Modifier' : 'Suivant'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
