import 'package:central_auto/model/cars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carCard.dart';

class CarFav extends StatelessWidget {
  const CarFav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Car> cars = Provider.of<List<Car>>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      body: cars == null
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : cars.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/images/parking.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              : ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (ctx, i) {
                    final car = cars[i];
                    return cars == null
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          )
                        : CarCard(car: car);
                  }),
    );
  }
}
