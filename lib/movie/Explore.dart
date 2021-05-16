import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/movie/askme/Askme.dart';

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
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            post = text;
                          });
                        },
                        decoration: InputDecoration(hintText: 'Type here'),
                      )
                    ],
                  ),
                ),
          actions: <Widget>[
            TextButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Post'),
              onPressed: () {
                if (post == "") {
                } else {
                  show = true;
                  postdata().then((value) => {
                        this.getpostdata().then((value) => {
                              if (mounted)
                                {
                                  setState(() {
                                    postlist = value["post"];
                                    show = false;
                                  }),
                                },
                              Navigator.of(context).pop()
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
          title: Text(
            'Explore',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
