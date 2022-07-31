// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:image_picker/image_picker.dart';

import '../../share/getImage.dart';
import '../user/user_data.dart';
import '../widgets/appbar_widget.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  var user = UserData.myUser;
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 330,
            child: Text(
              "Ajoutez votre photo de profil:",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 330,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(90, 55),
                ),
                onPressed: () async {
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
                child: const Text(
                  'Ajouter une photo',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Mettre à jour',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          for (int i = 0; i < images.length; i++)
            Container(
              //color: Colors.amber,
              margin: const EdgeInsets.only(right: 3, left: 3),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.file(
                      fit: BoxFit.cover,
                      images[0],
                      height: 250,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.minusCircle,
                        color: Colors.red,
                        size: 30,
                      ),
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
    );
  }
}
