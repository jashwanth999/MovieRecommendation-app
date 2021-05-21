import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter_app/components/wachlist/Createplaylist.dart';
import 'package:flutter_app/components/wachlist/watchlistmovies.dart';
import 'package:dio/dio.dart';
import 'package:shimmer/shimmer.dart';

class Watchlist extends StatefulWidget {
  final id;
  final username;
  Watchlist({Key key, @required this.username, this.id}) : super(key: key);
  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  List watchlist;
  String watchlistname;
  Future postdata() async {
    final String url = "https://fast-tor-93770.herokuapp.com/watch";
    dynamic dat = {
      "userid": widget.id,
      "username": widget.username,
      "timestamp": DateTime.now().toString(),
      "watchlist": [
        {
          "watchlistname": watchlistname,
        }
      ]
    };

    try {
      var response = await Dio().post(url,
          data: dat,
          options: Options(
              headers: {'Content-Type': 'application/json;charset=UTF-8'}));
      return response.data["post"];
    } catch (e) {
      print(e);
    }
  }

  List random = [
    "https://media4.giphy.com/media/FjOsaw9z4BhrW/giphy.webp?cid=ecf05e47eute4qggz1w4r9xvmvfrz9rp5sb137m69oueuel6&rid=giphy.webp&ct=g",
    "https://media4.giphy.com/media/hvdL7Xcmperfi/200w.webp?cid=ecf05e47eute4qggz1w4r9xvmvfrz9rp5sb137m69oueuel6&rid=200w.webp&ct=g",
    "https://media2.giphy.com/media/EOfarA6ZUqzZu/giphy.webp?cid=ecf05e47reqkq2a2b4z9qd8glcnitq4zmx0p4cvrfwuzjxxh&rid=giphy.webp&ct=g",
    "https://media1.giphy.com/media/OPOIcmwa6Ew2A/giphy.webp?cid=ecf05e47jrjqiwc0qsq96bwibzcrrqdmj84xl8a4kuvg4oo0&rid=giphy.webp&ct=g",
    "https://media3.giphy.com/media/ZCU3YxmmD8lh6savbB/giphy.webp?cid=ecf05e470ruaj4i5c77h2xuitfl1hzc7gg785m3c23k4vuxw&rid=giphy.webp&ct=g",
    "https://media3.giphy.com/media/11OOAQSnUaZT2M/200w.webp?cid=ecf05e47ll9grii3i5nt42w9g0ktp1tyk989w5e9g5cxr1fc&rid=200w.webp&ct=g",
    "https://media4.giphy.com/media/fIIu2R4Z57iMw/giphy.webp?cid=ecf05e471yhc4ruonuc9pdac60r5j7nye28gdmpi47i2h9x7&rid=giphy.webp&ct=g",
    "https://media3.giphy.com/media/NENOgw8mgH0NW/giphy.webp?cid=ecf05e471yhc4ruonuc9pdac60r5j7nye28gdmpi47i2h9x7&rid=giphy.webp&ct=g"
        "https://media2.giphy.com/media/zRQIOikoG10CMxtpBh/200w.webp?cid=ecf05e47o9094zwn0qatljlqxx6rqqrvnsaybgl96cihigfh&rid=200w.webp&ct=g",
    "https://media0.giphy.com/media/GRM7Z2s6AougoR3rvv/200w.webp?cid=ecf05e47o9094zwn0qatljlqxx6rqqrvnsaybgl96cihigfh&rid=200w.webp&ct=g"
        "https://media0.giphy.com/media/c67v7Gkbr6bYOf5O4s/200w.webp?cid=ecf05e47cg1nqdxowvsyx5k7sdiudbj28yv4i3hsuwddf1mi&rid=200w.webp&ct=g"
  ];
  Future getpostdata() async {
    final String url =
        "https://fast-tor-93770.herokuapp.com/watch/" + widget.id;
    try {
      var response = await Dio().get(url);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    this.getpostdata().then((value) => {
          if (mounted)
            {
              setState(() {
                watchlist = value["post"];
              }),
            }
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(171, 178, 185, 1),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      bottom: 5,
                    ),
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: SingleChildScrollView(
                        child: TextField(
                      maxLines: 1,
                      minLines: 1,
                      onChanged: (text) {
                        setState(() {
                          watchlistname = text;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Create Watchist'),
                    ))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ADD'),
              onPressed: () async {
                if (watchlistname == null || watchlistname == "") {
                } else {
                  await postdata().then((value) => {
                        setState(() {
                          getpostdata().then((value) => {
                                if (mounted)
                                  {
                                    setState(() {
                                      watchlist = value["post"];
                                    }),
                                  }
                              });
                        }),
                        Navigator.pop(context)
                      });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showMyDialog();
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.pink,
        ),
        body: watchlist == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                    itemCount: watchlist.length == 0
                        ? 0
                        : watchlist[0]["watchlist"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Watchlistmovies(
                                      username: widget.username,
                                        userid: widget.id,
                                        watchlistname:watchlist[0]

                                            ["watchlist"][index]['watchlistname'],
                                        watchlistmovieid: watchlist[0]

                                            ["watchlist"][index]['_id'])));
                          },
                          child: Container(
                              height: 159,
                              decoration: BoxDecoration(
                                  color: Colors.pink.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                        color:
                                            Color.fromRGBO(255, 255, 250, 0.5),
                                        colorBlendMode: BlendMode.modulate,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        image: NetworkImage(random[
                                            Random().nextInt(random.length)])),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 0,
                                      child: Icon(Icons.more_vert,
                                          color: Colors.white)),
                                  Positioned(
                                      bottom: 10,
                                      child: Shimmer.fromColors(
                                          period: Duration(milliseconds: 2000),
                                          baseColor: Colors.grey[100],
                                          direction: ShimmerDirection.ltr,
                                          highlightColor: Colors.grey[800],
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Text(
                                                watchlist[0]["watchlist"][index]
                                                            ["watchlistname"] ==
                                                        null
                                                    ? ""
                                                    : watchlist[0]["watchlist"]
                                                                [index]
                                                            ["watchlistname"]
                                                        .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                          ))),
                                ],
                              )));
                    }),
              ));
  }
}
