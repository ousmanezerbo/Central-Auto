import 'dart:ffi';

import 'package:central_auto/carScreen/carAdd.dart';
import 'package:central_auto/carScreen/carCard.dart';
import 'package:central_auto/model/cars.dart';
//import 'package:central_auto/nouveau/carCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListCar extends StatefulWidget {
  const ListCar({Key? key}) : super(key: key);

  @override
  State<ListCar> createState() => _ListCarState();
}

class _ListCarState extends State<ListCar> {
  List<Car> _carList = [];
  List<Car> _newCarList = [];

  @override
  void initState() {
    _newCarList = _carList;
    super.initState();
  }

  void _onItemChanged(String keyWord) {
    List<Car> results = [];
    if (keyWord.isEmpty) {
      results = _carList;
    } else {
      results = _carList.where((val) {
        return val.Marque!.toLowerCase().contains(keyWord.toLowerCase()) ||
            val.Model!.toLowerCase().contains(keyWord.toLowerCase()) ||
            val.Annee!.toLowerCase().contains(keyWord.toLowerCase()) ||
            val.Carburant!.toLowerCase().contains(keyWord.toLowerCase()) ||
            val.Carosserie!.toLowerCase().contains(keyWord.toLowerCase()) ||
            val.Etat!.toLowerCase().contains(keyWord.toLowerCase()) ||
            val.Prix!.toLowerCase().contains(keyWord.toLowerCase()) ||
            val.Transmission!.toLowerCase().contains(keyWord.toLowerCase());
      }).toList();
      setState(() {
        _newCarList = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    _carList = Provider.of<List<Car>>(context);
    print(_carList);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.library_add_sharp),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 35),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: TextField(
                          // autofocus: true,
                          onChanged: (value) => _onItemChanged(value),
                          // controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Rechercher...',
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            /*  suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.grey,
                                size: 25,
                              ),
                            ), */
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            /* TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Rechercher...",
                hintStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) => _onItemChanged(value),
            ), */
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: _newCarList.isNotEmpty
                ? ListView.builder(
                    itemCount: _newCarList.length,
                    itemBuilder: (ctx, i) {
                      final car = _newCarList[i];
                      return car == null
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            )
                          : CarCard(car: car);
                    })
                : ListView.builder(
                    itemCount: _carList.length,
                    itemBuilder: (ctx, i) {
                      final car = _carList[i];
                      return car == null
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            )
                          : CarCard(car: car);
                    }),
          )
        ],
      ),
    );
  }
}
