import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect/multiselect.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final posterController = TextEditingController();
  List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Add Movie'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Colors.black),
              ),
              title: Row(
                children: [
                  Text('Nom : '),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: nameController,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Colors.black),
              ),
              title: Row(
                children: [
                  Text('Année : '),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: yearController,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Colors.black),
              ),
              title: Row(
                children: [
                  Text('Poster : '),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: posterController,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DropDownMultiSelect(
              onChanged: (List<String> x) {
                setState(() {
                  categories = x;
                });
              },
              options: const ['Action', 'S-F', 'Aventure', 'Comédie'],
              selectedValues: categories,
              whenEmpty: 'Categories',
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  FirebaseFirestore.instance.collection('Movies').add({
                    'name': nameController.value.text,
                    'year': yearController.value.text,
                    'poster': posterController.value.text,
                    'categories': categories,
                    'likes': 0,
                  });
                },
                child: const Text("Ajouter")),
          ],
        ),
      ),
    );
  }
}
