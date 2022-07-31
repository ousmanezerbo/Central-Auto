import 'package:central_auto/carScreen/carAdd.dart';
import 'package:central_auto/carScreen/carCard.dart';
import 'package:central_auto/model/cars.dart';
//import 'package:central_auto/nouveau/carCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../film/add_movie_page.dart';

class listCar extends StatefulWidget {
  const listCar({Key? key}) : super(key: key);

  @override
  State<listCar> createState() => _listCarState();
}

class _listCarState extends State<listCar> {
  @override
  Widget build(BuildContext context) {
    final List<Car> cars = Provider.of<List<Car>>(context);
    print(cars);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.library_add_sharp),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CarAdd()),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Central Auto'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (ctx, i) {
            final car = cars[i];
            return car == null
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  )
                : CarCard(car: car);

            /* ListTile(
              leading: Container(
                child: Image(image: NetworkImage(car.images![0])),
              ),
              title: Text(car.Annee.toString()),
            ); */
          }),
    );
  }
}
