import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/movie/askme/Askme.dart';
import 'package:shimmer/shimmer.dart';

class Explore extends StatefulWidget {
  final id;
  final username;
  Explore({Key key, @required this.id, this.username}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String post;
  bool show = false;

  Future postdata() async {
    final String url = "https://fast-tor-93770.herokuapp.com/post";
    dynamic dat = {
      "userid": widget.id,
      "username": widget.username,
      "postdata": post,
      "timestamp": DateTime.now().toString()
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

  List postlist;
  Future getpostdata() async {
    final String url = "https://fast-tor-93770.herokuapp.com/post";
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
                postlist = value["post"];
              }),
            }
        });
  }

  Future<void> _showMyDialogs() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                width: 50,
                height: 50,
                child: Center(
                    child: Row(
                  children: [
                    CircularProgressIndicator(),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))),
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(171, 178, 185, 1),
          content: show == true
              ? Container(
                  width: 50,
                  height: 50,
                  child: Center(
                      child: Row(
                    children: [
                      CircularProgressIndicator(),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          'Loading...',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )))
              : SingleChildScrollView(
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
                            maxLines: 3,
                            minLines: 3,
                            onChanged: (text) {
                              setState(() {
                                post = text;
                              });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type here..'),
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
              child: Text('POST'),
              onPressed: () {
                if (post == null) {
                } else if (widget.id == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Container(
                        height: 25,
                        alignment: Alignment.center,
                        child: Text("PLEASE LOGIN",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      action: SnackBarAction(
                        label: 'Cancel',
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                    ),
                  );
                } else {
                  show = true;
                  Navigator.pop(context);
                  // _showMyDialogs();
                  postdata().then((value) => {
                        this.getpostdata().then((value) => {
                              if (mounted)
                                {
                                  setState(() {
                                    postlist = value["post"];
                                  }),
                                },
                              setState(() {
                                post = "";
                              }),
                            }),
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
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Shimmer.fromColors(
              period: Duration(milliseconds: 2000),
              baseColor: Colors.grey[300],
              direction: ShimmerDirection.ltr,
              highlightColor: Colors.grey[600],
              child: Text(
                'Ask here',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (widget.id == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    height: 25,
                    alignment: Alignment.center,
                    child: Text("PLEASE LOGIN",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  action: SnackBarAction(
                    label: 'Cancel',
                    onPressed: () {
                     
                    },
                  ),
                ),
              );
            } else
              _showMyDialog();
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: postlist != null
            ? Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black),
                child: ListView.builder(
                    itemCount: postlist.length == null ? 0 : postlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Askme(
                        postid: postlist[index]['_id'],
                        id: widget.id,
                        username: postlist[index]['username'],
                        postdata: postlist[index]['postdata'],
                      );
                    }))
            : (Center(child: CircularProgressIndicator())));
  }
}
