import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul7/hex_color.dart';
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
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _editfakultasController = TextEditingController();
  final TextEditingController _editjurusanController = TextEditingController();
  final TextEditingController _editdetailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: HexColor("FC997C")),
      accountName: Text(
        'QIW QIW',
      ),
      accountEmail: Text(
        'qiwqiw@gmail.com',
      ),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );

    // Define the items that will be displayed in the drawer. In this case, we have two items.
    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: const Text(
            'LOPYUU',
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            // When the user taps on this item, close the drawer.
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text(
            'Page 2',
          ),
          leading: const Icon(Icons.comment),
          onTap: () {
            // When the user taps on this item, close the drawer.
            Navigator.pop(context);
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Study Program",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: HexColor("FC997C"),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
      backgroundColor: HexColor("FC997C"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
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
                            TextField(
                              controller: _detailController,
                              decoration:
                                  InputDecoration(labelText: 'Detail'),      
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
                                _detailController.text,
                              );
                              _fakultasController.clear();
                              _jurusanController.clear();
                              _imageController.clear();
                              _detailController.clear();
                              Navigator.of(context).pop();
                            },
                            child: Text('Simpan'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Tambah Data",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
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
                                                                TextField(
                                                                  controller:
                                                                      _editdetailController,
                                                                  decoration: InputDecoration(
                                                                      labelText:
                                                                          'Detail'),
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
                                                                          .id,_editdetailController.text);
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
                                                      Icons.edit,
                                                      color: Colors.green,
                                                      // size: 30,
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
                                                      // size: 30,
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
