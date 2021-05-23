import 'package:flutter/material.dart';

class Aboutme extends StatefulWidget {
  Aboutme({Key key}) : super(key: key);
  @override
  _AboutmeState createState() => _AboutmeState();
}

class _AboutmeState extends State<Aboutme> {
  List about = [
    "",
    "Hi there! JASHWANTH here.",
    "API used from TMDB.",
    "SENTIMENT ANALYSIS APPLIED ON MOVIE REVIEWS.",
    "Basically this is my personal project.",
    "if you like the app you can rate this app.",
    "ANY QUERIES VISIT THE SITE GIVEN LINK IN THE BELOW.",
    "GITHUB : https://github.com/jashwanth999",
    "WEBSITE : https://jashwanth.netlify.app/"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "ABOUT",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: about.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0)
                  return Container(
                      height: 150,
                      width: 100,
                      child: Image(
                        color: Colors.pink,
                        fit: BoxFit.contain,
                        image: AssetImage("images/logo3.png"),
                      ));
                return Container(
                    margin: EdgeInsets.all(10),
                    child: Text("->  " + about[index].toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.5,
                            fontWeight: FontWeight.bold)));
              })),
    );
  }
}
