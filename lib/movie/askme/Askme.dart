import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/movie/askme/Answer.dart';

class Askme extends StatefulWidget {
  final username;
  final postdata;
  final postid;
  final id;
  Askme({Key key, @required this.username, this.postdata, this.postid, this.id})
      : super(key: key);

  @override
  _AskmeState createState() => _AskmeState();
}

class _AskmeState extends State<Askme> {
  bool follow = false;
  bool like = false;
  List colors = [
    {
      "color": Color.fromRGBO(145, 112, 157, 2),
    },
    {
      "color": Color.fromRGBO(255, 87, 51, 2),
    },
    {
      "color": Color.fromRGBO(51, 255, 72, 2),
    },
    {
      "color": Color.fromRGBO(250, 215, 160, 2),
    },
    {
      "color": Color.fromRGBO(214, 137, 16, 2),
    },
    {
      "color": Color.fromRGBO(26, 188, 156, 2),
    },
    {
      "color": Color.fromRGBO(36, 113, 163, 2),
    }
  ];
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: new BoxConstraints(
        minHeight: 40.0,
      ),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(2)),
      margin: EdgeInsets.all(3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          gethead(widget.username),
          getquestion(widget.postdata),
          getbottomhead(),
          Container(
            child: Divider(
              color: Colors.grey,
              thickness: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget getquestion(username) {
    return Container(
        padding: EdgeInsets.only(top: 5, left: 10, bottom: 10),
        alignment: Alignment.topLeft,
        child: Text(
          username == null ? "" : username,
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ));
  }

  Widget gethead(val) {
    return Container(
        margin: EdgeInsets.all(5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  child: Text(
                    val[0],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: colors[Random().nextInt(colors.length)]['color'],
                    borderRadius: BorderRadius.circular(120),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(val,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ],
          ),
        ]));
  }

  Widget getbottomhead() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          createbutton(),
          GestureDetector(
              onTap: () {
                setState(() {
                  like = !like;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Icon(Icons.thumb_up,
                    size: 28, color: like ? Colors.pink : Colors.white),
              )),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            child: Icon(Icons.bookmark, size: 28, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget createbutton() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, bottom: 5),
      height: 40.0,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Answer(
                      postid: widget.postid,
                      userid: widget.id,
                      username: widget.username)));
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(18.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 100.0, minHeight: 30.0),
            alignment: Alignment.center,
            child: Text(
              "Answer",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
