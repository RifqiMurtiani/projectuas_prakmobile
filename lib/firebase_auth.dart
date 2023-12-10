import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul7/login.dart';

class FirebaseAuthService {
  FirebaseAuth _authService = FirebaseAuth.instance;

  singUpWithEmailandPassword(String email, password, BuildContext context,
      String telp, String pendidikan, String nama) async {
    try {
      await _authService
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              {postDetailsToFirestore(email, telp, pendidikan, nama)});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User is Successfully created"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
    // return null;
  }

  postDetailsToFirestore(
      String email, String telp, String pendidikan, String nama) async {
    // Fluttertoast.showToast(msg: "Register Berhasil");
    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _authService.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set(
        {'email': email, 'telp': telp, 'pendidikan': pendidikan, 'nama': nama});
  }
  // Future<User?> singUpWithEmailandPassword(
  //     String email, password, BuildContext context, String telp, String pendidikan,String nama) async {
  //   try {
  //     UserCredential credential = await _authService
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //     .then((value) {

  //     });
  //     return credential.user;
  //   } catch (e) {
  //     final String errorMessage = e.toString();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(errorMessage),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  //   return null;
  // }

  Future<User?> loginWithEmailandPassword(
      String email, password, BuildContext context) async {
    try {
      UserCredential credential = await _authService.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }
}
