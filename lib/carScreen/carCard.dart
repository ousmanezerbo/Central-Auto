import 'package:cached_network_image/cached_network_image.dart';
import 'package:central_auto/carScreen/carDetails.dart';
import 'package:central_auto/model/cars.dart';
import 'package:central_auto/settingUser/user/user.dart';
//import 'package:central_auto/nouveau/carCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarCard extends StatelessWidget {
  CarCard({Key? key, required this.car}) : super(key: key);
  Car car;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CarDetails(
                      car: car,
                    )));
          },
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
                          shape: CircleBorder(),
                          onPressed: () {},
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.lightBlue,
                            size: 20,
                          ),
                        ),
                      ),
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
