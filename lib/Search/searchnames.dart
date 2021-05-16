import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/navigations/Topbar.dart';

class Searchnames extends StatefulWidget {
  Searchnames({Key key}) : super(key: key);

  @override
  _SearchnamesState createState() => _SearchnamesState();
}

class _SearchnamesState extends State<Searchnames> {
  List names;
  String k;

  Future getpopularresponse() async {
    try {
      var response = await Dio().get("http://movie-bj-9.herokuapp.com/getname");
      var data = response.data;
      return data;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getpopularresponse().then((value) => {
          setState(() {
            names = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: TextField(
              onChanged: (text) {
                setState(() {
                  k = text;
                });
              },
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: InputBorder.none,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Search'),
            ),
          ),
          leading: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            backgroundColor: Colors.green,
          ),
        ),
        body: getname());
  }

  Widget getname() {
    if (k == null || k == "")
      return Center(
          child: Container(
              child: Text(
        "🎥   🍟    😋",
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
        ),
      )));
    if (names == null)
      return Center(
        child: CircularProgressIndicator(),
      );

    List dat = names.where((f) => f.contains(k)).toList();

    return Container(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: ListView.builder(
            itemCount: dat.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Topbar(
                                  moviename: dat[index],
                                )));
                  },
                  child: Container(
                      margin: EdgeInsets.all(4),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      dat[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    )))
                          ])));
            }));
  }
}
