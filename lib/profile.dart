import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul7/firebase_auth.dart';
import 'package:modul7/hex_color.dart';
import 'package:modul7/login.dart';
import 'package:modul7/model/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _authService = FirebaseAuth.instance;
  UserModel datauser = UserModel();
  String nama = '';
  getUserInfo() {
    String uid = _authService.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .listen((event) {
      datauser = UserModel.fromJson(event.data()!);
      print(datauser.nama);
    });
    // print(datauser.nama);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String uid = _authService.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .listen((event) {
      datauser = UserModel.fromJson(event.data()!);
      print(datauser.nama);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: HexColor("FC997C"),
      ),
      backgroundColor: HexColor("FC997C"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            containerProfile(
                Icons.account_box_outlined, "Nama", datauser.nama.toString()),
            containerProfile(Icons.school_outlined, "Pendidikan",
                datauser.pendidikan.toString()),
            containerProfile(
                Icons.phone_outlined, "Telepon", datauser.telp.toString()),
            containerProfile(
                Icons.email_outlined, "Email", datauser.email.toString()),
            // containerProfile(Icons.logout_outlined, "Logout", ""),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      size: 26,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget containerProfile(IconData icon, String title, String subtitle) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1),
      ),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          size: 26,
        ),
        Expanded(
          child: ListTile(
            title: Text(title),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            subtitle: Text(subtitle),
          ),
        ),
      ],
    ),
  );
}
