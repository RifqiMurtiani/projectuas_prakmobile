import 'package:flutter/material.dart';
import 'package:modul7/model/reqresuser.dart';
import 'package:modul7/viewmodel/services.dart';

class TestReqresPage extends StatefulWidget {
  const TestReqresPage({super.key});

  @override
  State<TestReqresPage> createState() => _TestReqresPageState();
}

class _TestReqresPageState extends State<TestReqresPage> {
  ReqresUser? reqresuser;
  bool isLoading = false;
  String id = '3';
  TextEditingController idController =
      TextEditingController(); // Tambahkan controller

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getReqresUser(id).then((value) {
      reqresuser = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('reqres test', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(reqresuser!.data.avatar),
                  ),
                  Text(reqresuser!.data.firstName),
                  Text(reqresuser!.data.lastName),
                  Text(reqresuser!.data.email),
                  // Tambahkan input teks di sini
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: idController, // Menggunakan controller
                      decoration: InputDecoration(
                        labelText: 'ID', // Label untuk input teks
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Ketika tombol ditekan, perbarui ID dengan nilai dari input teks
                      setState(() {
                        id = idController.text;
                      });
                      // Kemudian panggil fungsi getReqresUser untuk memperbarui data
                      isLoading = true;
                      getReqresUser(id).then((value) {
                        reqresuser = value;
                        isLoading = false;
                        setState(() {});
                      });
                    },
                    child: Text('Ganti ID'), // Text pada tombol
                  ),
                ],
              ),
      ),
    );
  }
}
