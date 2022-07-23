import 'package:intl_phone_field/phone_number.dart';

class UserM {
  String id, email, nom, prenom, numero, image;
  /*  bool admin, enable; */
  static UserM? currentUser;
  UserM({
    required this.id,
    required this.email,
    required this.nom,
    required this.prenom,
    required this.numero,
    required this.image,
    /* this.image,
      this.admin = false,
      this.enable = true */
  });
  factory UserM.fromJson(Map<String, dynamic> j) => UserM(
        email: j['email'],
        id: j['id'],
        nom: j['nom'],
        prenom: j['prenom'],
        numero: j['numero'],
        image: j['image'],
        /*  image: j['image'],
      admin: j['admin'],
      enable: j["enable"] */
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "nom": nom,
        "prenom": prenom,
        "numero": numero,
        "image": image,
      };
}
