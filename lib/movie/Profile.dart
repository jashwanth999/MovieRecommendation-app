import 'package:flutter/material.dart';
import 'package:flutter_app/components/auth/Login.dart';
import 'package:flutter_app/components/profiles/Aboutme.dart';
import 'package:flutter_app/components/wachlist/Bookmarks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final id;
  final username;
  Profile({Key key, @required this.id, this.username}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  launchurl() async {
    String url = "https://jashwanth.netlify.app/";
    if (await canLaunch(url) != null) {
      launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 25,
            alignment: Alignment.center,
            child: Text("Trailer not found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          action: SnackBarAction(
            label: 'Cancel',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.0, 0.0),
                colors: <Color>[
                  Color.fromRGBO(145, 112, 157, 2),
                  Color.fromRGBO(6, 0, 8, 2)
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    gethead(),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bookmarks(
                                      userid: widget.id,
                                      username: widget.username)));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 20, left: 25),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(
                                        Icons.bookmark,
                                        color: Colors.white,
                                        size: 23,
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "BOOKMARKS",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]))),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 25),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(15),
                                  child: Icon(
                                    FontAwesome.star_half_empty,
                                    color: Colors.white,
                                    size: 23,
                                  )),
                              Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  "RATE APP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ])),
                    InkWell(
                        onTap: () {
                          launchurl();
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, left: 25),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(
                                        Icons.contact_page,
                                        color: Colors.white,
                                        size: 23,
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "CONTACT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]))),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Aboutme()));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, left: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: Icon(
                                      FontAwesome.question_circle,
                                      color: Colors.white,
                                      size: 23,
                                    )),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    "ABOUT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ))),
                    InkWell(
                        onTap: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove("userid");
                          sharedPreferences.remove("username");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, left: 25),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(
                                        FontAwesome.sign_out,
                                        color: Colors.white,
                                        size: 23,
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "SIGN OUT",
                                      style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ])))
                  ]),
            )));
  }

  Widget gethead() {
    return Container(
        margin: EdgeInsets.only(
          top: 70,
        ),
        alignment: Alignment.center,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              alignment: Alignment.center,
              height: 120,
              width: 120,
              child: Text(
                widget.username[0],
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(120),
              )),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              widget.username,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ]));
  }
}
