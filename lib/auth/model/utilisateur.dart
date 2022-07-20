class UserM {
  String id, email, nom, prenom /* image */;
  /*  bool admin, enable; */
  static UserM? currentUser;
  UserM({
    required this.id,
    required this.email,
    required this.nom,
    required this.prenom,
    /* this.image,
      this.admin = false,
      this.enable = true */
  });
  factory UserM.fromJson(Map<String, dynamic> j) => UserM(
        email: j['email'],
        id: j['id'],
        nom: j['nom'],
        prenom: j['prenom'],
        /*  image: j['image'],
      admin: j['admin'],
      enable: j["enable"] */
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "nom": nom,
        "prenom": prenom,
      };
}
