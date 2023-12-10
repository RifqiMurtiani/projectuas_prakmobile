import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul7/firebase_auth.dart';
import 'package:modul7/hex_color.dart';
import 'package:modul7/onBoard.dart';
import 'package:modul7/register.dart';
// ignore: unused_import
import 'package:modul7/viewmodel/home_user.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user =
        await _authService.loginWithEmailandPassword(email, password, context);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login success"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoard()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                      "Welcome",
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
                initialChildSize: 0.6,
                minChildSize: 0.2,
                maxChildSize: 0.6,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text(
                          //   "Login to continue",
                          //   style: TextStyle(
                          //       fontSize: 24, fontWeight: FontWeight.w700),
                          // ),
                          const SizedBox(
                            height: 20.0,
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
                                  login();
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don’t have an account?"),
                              const SizedBox(width: 4.0),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Register.",
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
