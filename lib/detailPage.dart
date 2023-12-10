import 'package:flutter/material.dart';
import 'package:modul7/hex_color.dart';

class DetailPage extends StatefulWidget {
  final String image, jurusan, fakultas, detail;
  const DetailPage(
      {super.key,
      required this.image,
      required this.jurusan,
      required this.fakultas,
      required this.detail});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("FC997C"),
        title: Text("Detail Page"),
        centerTitle: true,
      ),
      backgroundColor: HexColor("FC997C"),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(widget.image),
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.jurusan,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "Fakultas : " + widget.fakultas,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.detail,
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}
