import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul7/login.dart';
import 'firestore_service.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController _fakultasController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _editfakultasController = TextEditingController();
  final TextEditingController _editjurusanController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "List of Study Program",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Tambah Study Program'),
                        content: Column(
                          children: [
                            TextField(
                              controller: _fakultasController,
                              decoration:
                                  InputDecoration(labelText: 'Fakultas'),
                            ),
                            TextField(
                              controller: _jurusanController,
                              decoration: InputDecoration(labelText: 'Jurusan'),
                            ),
                            TextField(
                              controller: _imageController,
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              firestoreService.addstudyprogram(
                                _fakultasController.text,
                                _jurusanController.text,
                                _imageController.text,
                              );
                              _fakultasController.clear();
                              _jurusanController.clear();
                              _imageController.clear();
                              Navigator.of(context).pop();
                            },
                            child: Text('Simpan'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Tambah Data",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: Text('Sign out')),
              StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getstudyprogram(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      List userList = snapshot.data!.docs;
                      return SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot = userList[index];
                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Material(
                                color: Colors.purple[50],
                                elevation: 2,
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SizedBox(
                                              width: 120,
                                              child: Image(
                                                  image: NetworkImage(
                                                      data['image'])),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['fakultas'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(data['jurusan']),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 140,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Edit Study Program'),
                                                            content: Column(
                                                              children: [
                                                                TextField(
                                                                  controller:
                                                                      _editfakultasController,
                                                                  decoration: InputDecoration(
                                                                      labelText:
                                                                          'Fakultas'),
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      _editjurusanController,
                                                                  decoration: InputDecoration(
                                                                      labelText:
                                                                          'Jurusan'),
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  firestoreService.updatestudyprogram(
                                                                      _editfakultasController
                                                                          .text,
                                                                      _editjurusanController
                                                                          .text,
                                                                      documentSnapshot
                                                                          .id);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    'Simpan'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.add_box_rounded,
                                                      color: Colors.green,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Apakah yakin ingin menghapus data?'),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    firestoreService
                                                                        .deletestudyprogram(
                                                                            documentSnapshot.id);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'Hapus'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
