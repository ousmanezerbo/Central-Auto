import 'package:cached_network_image/cached_network_image.dart';
import 'package:central_auto/auth/widgets/loading.dart';
import 'package:central_auto/carScreen/carDetails.dart';
import 'package:central_auto/carScreen/updateCar.dart';
import 'package:central_auto/model/bdcars.dart';
import 'package:central_auto/model/cars.dart';
import 'package:central_auto/settingUser/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:central_auto/nouveau/carCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CarCard extends StatelessWidget {
  CarCard({Key? key, required this.car}) : super(key: key);
  Car car;
  Icon favIcon = const Icon(
    FontAwesomeIcons.heart,
    size: 20,
  );

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (car.Favoris!.contains(user!.uid)) {
      favIcon = const Icon(
        FontAwesomeIcons.solidHeart,
        color: Colors.lightBlue,
        size: 20,
      );
    } else {
      favIcon = const Icon(
        FontAwesomeIcons.solidHeart,
        color: Colors.grey,
        size: 20,
      );
    }
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CarDetails(
                      car: car,
                    )));
          },
          onDoubleTap: () {},
          child: Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 200, 209, 218),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 4,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Column(
              children: [
                Container(
                  height: 248,
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          car.images!.first,
                        ),
                        fit: BoxFit
                            .cover), /* NetworkImage(car.images![0]), fit: BoxFit.cover */
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        right: -10,
                        child: MaterialButton(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          child: favIcon,
                          onPressed: () async {
                            if (car.Favoris!.contains(user.uid)) {
                              car.Favoris!.remove(user.uid);
                            } else {
                              car.Favoris!.add(user.uid);
                            }
                            await CarDB().updateCar(car);
                          },
                        ),
                      ),
                      if (car.uid == FirebaseAuth.instance.currentUser!.uid)
                        Positioned(
                          top: 10,
                          left: -10,
                          child: MaterialButton(
                            color: Colors.white,
                            shape: const CircleBorder(),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Suppression'),
                                      content: const Text(
                                          'Voulez vous vraiment supprimer ce poste ?'),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                            onPressed: () async {
                                              loading(context);
                                              bool delete = await CarDB()
                                                  .deleteCar(car.id.toString());
                                              if (delete != null) {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text('Oui',
                                                style: TextStyle(
                                                    color: Colors.red))),
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Non',
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        )
                      else
                        Container(),
                      if (car.uid == FirebaseAuth.instance.currentUser!.uid)
                        Positioned(
                          top: 10,
                          left: 50,
                          child: MaterialButton(
                            color: Colors.white,
                            shape: const CircleBorder(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CarUpdate(
                                  car: car,
                                ),
                              ));
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.lightBlue,
                              size: 20,
                            ),
                          ),
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        car.Marque.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 11, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        car.Model.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 11, fontWeight: FontWeight.w800),
                      ),
                      /* SizedBox(
                              width: 81,
                            ), */
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        car.Annee.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 9, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "${car.Prix} Fcfa",
                        style: GoogleFonts.nunito(
                            fontSize: 11, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
