import 'package:flutter/material.dart';
import 'package:flutter_app/components/auth/Login.dart';
import 'package:flutter_app/components/wachlist/Bookmarks.dart';
import 'package:flutter_app/components/watchlistbar.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Profile extends StatefulWidget {
  final id;
  final username;
  Profile({Key key, @required this.id, this.username}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        gethead(),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Bookmarks(
                          userid: widget.id, username: widget.username)));
            },
            child: Container(
                margin: EdgeInsets.only(top: 20, left: 0),
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
                          "SAVED",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]))),
        Container(
            margin: EdgeInsets.only(top: 10, left: 0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  "Rate App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ])),
        Container(
            margin: EdgeInsets.only(top: 10, left: 0),
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
                    "About",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Container(
                margin: EdgeInsets.only(top: 10, left: 0),
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
                          "Sign Out",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ])))
      ]),
    );
  }

  Widget getpublicplay() {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      alignment: Alignment.center,
      child: Text(
        "Settings",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getfollowers() {
    return Container(
        margin: EdgeInsets.only(top: 30, left: 20, right: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text("3",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Text("Playlist",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ])),
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text("0",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Text("Followers",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ])),
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text("3",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Text("Following",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ]))
        ]));
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
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 20, right: 20, top: 3, bottom: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.white)),
            child: Text(
              "EDIT PROFILE",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ]));
  }
}
