import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  int? id;
  String? email;
  String? nama;
  String? telp;
  String? pendidikan;

  UserModel({
    this.id,
    this.email,
    this.nama,
    this.telp,
    this.pendidikan,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    nama = json["nama"];
    telp = json["telp"];
    pendidikan = json["pendidikan"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nama": nama,
        "last_name": telp,
        "pendidikan": pendidikan,
      };
}

// class UserRepository {
// final _db = FirebaseFirestore.instance;
// Future<UserModel> getUserDetail(String email) async {
//   final snapshot =
//       await _db.collection("Users").where("email", isEqualTo: email).get();
//   final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
//   return userData;
// }
// }
