import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:central_auto/auth/model/utilisateur.dart';
import 'package:central_auto/auth/services/db.dart';
import 'package:central_auto/model/cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CarDetails extends StatefulWidget {
  CarDetails({
    Key? key,
    required this.car,
  }) : super(key: key);
  Car car;
  UserM? user;
  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  getUser() async {
    final us = await DBServices().getUser(widget.car.uid.toString());
    if (us != null) {
      setState(() {
        widget.user = us;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user);
    return Scaffold(
      floatingActionButton: SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        label: const Text('Contact du vendeur'),
        spacing: 25,
        spaceBetweenChildren: 11,
        buttonSize: const Size(35, 40),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.mail),
            label: 'Mail',
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            onTap: () async {
              String email = widget.user!.email.toString();
              String subject = 'Voiture de Central Auto';
              String body =
                  'Bonjour! Je suis intéressé(e) par le poste de voitre voiture sur l\'application Cental Auto et j\'aimerai qu\'on en discute.';

              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: email,
                query: encodeQueryParameters(<String, String>{
                  'subject': subject,
                  'body': body,
                }),
              );
              if (await canLaunchUrl(emailUri)) {
                launchUrl(emailUri);
              } else {
                print('The action is not supported');
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            label: 'Téléphone',
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            onTap: () async {
              //if (widget.user != null)
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: widget.user!.numero.toString(),
              );
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                print("The action no supported.");
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.message),
            label: 'Message',
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'sms',
                path: widget.user!.numero.toString(),
              );
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                print("The action no supported.");
              }
            },
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Détails du véhicule'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: CarouselSlider.builder(
                itemCount: widget.car.images!.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        InkWell(
                  onTap: (() {
                    showDialog(
                        builder: (BuildContext context) => AlertDialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.all(2),
                              title: Container(
                                decoration: BoxDecoration(),
                                width: MediaQuery.of(context).size.width,
                                // height: MediaQuery.of(context).size.height,
                                child: Expanded(
                                  child: Image(
                                    image: CachedNetworkImageProvider(
                                      widget.car.images![itemIndex],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        context: context);
                  }),
                  child: Container(
                    height: 248,

                    //color: Colors.amber,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.car.images![itemIndex],
                          ),
                          fit: BoxFit
                              .cover), /* NetworkImage(car.images![0]), fit: BoxFit.cover */
                    ),
                  ),
                ),
                options: CarouselOptions(
                  height: 250,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.84,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  //onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            /* item('${widget.car.Marque} ${widget.car.Model}',
                FontAwesomeIcons.car),
            if (widget.user != null) Text(widget.user!.numero.toString()) */
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              // margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/voiture.png',
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Modèle',
                          style: GoogleFonts.nunito(
                              fontSize: 10, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    //widget.user!.nom.toString(),
                    widget.car.Marque.toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    "${widget.car.Model}",
                    style: GoogleFonts.nunito(
                        fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/don.png',
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Prix',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Text(
                        '${widget.car.Prix} Fcfa',
                        style: GoogleFonts.nunito(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/clef-de-voiture.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'État du véhicule',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.car.Etat.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/kilometrage.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Kilométrage',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.car.Kilometre.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/rendez-vous.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Année',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.car.Annee.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/transmission-manuelle.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Transmission',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.car.Transmission.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/pompe-a-petrole.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Carburant',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.car.Carburant.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/moteur-de-voiture.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Puissance',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.car.Puissance.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/porte-de-voiture.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Nombre de porte',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.car.Nbporte.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/voiture.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Carosserie',
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.car.Carosserie.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/voir-les-details.png',
                    height: 50,
                    width: 50,
                  ),
                  Text(
                    'Détails supplémentaires',
                    style: GoogleFonts.nunito(
                        fontSize: 10, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.car.Detailsup.toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 10, fontWeight: FontWeight.w800),
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile item(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
      ),
    );
  }
}
