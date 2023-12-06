import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference studyprogram =
      FirebaseFirestore.instance.collection('study program');

  var users;
  Stream<QuerySnapshot> getstudyprogram() {
    return studyprogram.snapshots();
  }

  // post
  Future<void> addstudyprogram(
      String fakultas, String jurusan, String image) async {
    studyprogram
        .add({'fakultas': fakultas, 'jurusan': jurusan, 'image': image});
  }

  //update
  Future<void> updatestudyprogram(
      String fakultas, String jurusan, String id) async {
    studyprogram.doc(id)
        .update({'fakultas': fakultas, 'jurusan': jurusan});
  }

  //delete
  Future<void> deletestudyprogram(String id) async {
    studyprogram.doc(id).delete();
  }

  void updateUser(String documentId, String text, String text2, String text3) {}

  void addUser(String text, String text2, String text3) {}

  void deleteUser(String id) {}

  getUsers() {}
}
