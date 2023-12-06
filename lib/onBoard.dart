import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modul7/hex_color.dart';
import 'package:modul7/viewmodel/home_user.dart';

import 'app_colors.dart';

class OnBoard extends StatefulWidget {
  OnBoard({super.key});
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentPageValue = 0;
  String buttonText = 'SKIP';
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void getChangedPageAndMoveBar(int page) {
    if (page == 2) {
      setState(() {
        buttonText = 'NEXT';
      });
    } else {
      setState(() {
        buttonText = 'SKIP';
      });
    }
    setState(() {
      currentPageValue = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 9,
              child: PageView(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int page) {
                  getChangedPageAndMoveBar(page);
                },
                children: <Widget>[
                  mainView('assets/1.jpg', "WELCOME TO MY APPS !", ''),
                  mainView('assets/2.jpg', "Mari kita mulai",
                      'Program ini berisi data yang menampilkan berbagai program study di Fakultas SAINTEK'),
                  mainView('assets/3.jpg', "Mari kita mulai",
                      'Salah satunya Teknik Informatika, Teknik Informatika merupakan prodi yang paling banyak diminati di Fakuktas SAINTEK ini')
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 35),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 3; i++)
                          if (i == currentPageValue) ...[
                            pageIndicator(true)
                          ] else
                            pageIndicator(false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  if (buttonText == "SKIP") {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut);
                  } else if (buttonText == "NEXT") {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const Login(),
                    //     ));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeUser(),
                        ));
                  }
                  // getChangedPageAndMoveBar(1);
                },
                child: Container(
                  width: double.infinity,
                  color: HexColor("FC997C"),
                  child: Center(
                    child: Text(buttonText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget pageIndicator(bool isActive) {
  return Container(
    height: 10,
    width: 10,
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? colorActive : colorInactive,
        borderRadius: const BorderRadius.all(
          Radius.elliptical(4, 4),
        ),
      ),
    ),
  );
}

Widget mainView(image, title, subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          // height: 150,
          // decoration: BoxDecoration(
          //   color: Colors.red,
          // ),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        // Image.asset(
        //   image,
        //   fit: BoxFit.none,
        // ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    ),
  );
}
