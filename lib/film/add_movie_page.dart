import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect/multiselect.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final MarqueController = TextEditingController();
  final ModelController = TextEditingController();
  final AnneeController = TextEditingController();
  final PrixController = TextEditingController();
  final ImageController = TextEditingController();
  List<String> Categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Car'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Colors.black),
              ),
              title: Row(
                children: [
                  const Text('Marque : '),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: MarqueController,
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
                  const Text('Model : '),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: ModelController,
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
                  const Text('Annee : '),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: AnneeController,
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
                  const Text('Prix : '),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: PrixController,
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
                  const Text('Image : '),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: ImageController,
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
                  Categories = x;
                });
              },
              options: const ['SUV', 'Berline', 'Coupé', 'Utilitaire'],
              selectedValues: Categories,
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
                  FirebaseFirestore.instance.collection('Cars').add({
                    'Marque': MarqueController.value.text,
                    'Model': ModelController.value.text,
                    'Annee': AnneeController.value.text,
                    'Prix': PrixController.value.text,
                    'Image': ImageController.value.text,
                    'Categories': Categories,
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
