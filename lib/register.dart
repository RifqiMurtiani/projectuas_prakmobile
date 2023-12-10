import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul7/firebase_auth.dart';
import 'package:modul7/hex_color.dart';
import 'package:modul7/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _telpController = TextEditingController();
  final TextEditingController _pendidikanController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String telp = _telpController.text;
    String pendidikan = _pendidikanController.text;
    String nama = _namaController.text;
    await _authService.singUpWithEmailandPassword(
      email,
      password,
      context,
      telp,
      pendidikan,
      nama,
    );

    // if (user != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("User is Successfully created"),
    //       backgroundColor: Colors.green,
    //     ),
    //   );
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => Login()));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("Cannot create user"),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: HexColor("FC997C"),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(image: AssetImage("assets/gambar_login.png")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Hello !!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.2,
                maxChildSize: 0.65,
                builder: (context, scrollController) {
                  return Container(
                    // width: double.infinity,
                    // height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: ListView(
                        controller: scrollController,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            controller: _namaController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_outlined),
                              hintText: "Nama",
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Email Address",
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.key),
                              hintText: "Password",
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextField(
                            controller: _telpController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.phone_outlined),
                              hintText: "No Telp",
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          TextField(
                            controller: _pendidikanController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.school_outlined),
                              hintText: "Pendidikan",
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor("319FC2"),
                                ),
                                onPressed: () {
                                  register();
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Do you have an account?"),
                              const SizedBox(width: 4.0),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Login.",
                                  style: TextStyle(
                                    color: Color.fromRGBO(49, 160, 194, 1),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
