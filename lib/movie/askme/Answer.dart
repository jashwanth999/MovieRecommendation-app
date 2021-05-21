import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Answer extends StatefulWidget {
  final postid;
  final userid;
  final username;

  Answer({Key key, @required this.postid, this.userid, this.username})
      : super(key: key);

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  String val;
  Future<void> _showMyDialog() async {
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

  Future postdata() async {
    final String url =
        "https://fast-tor-93770.herokuapp.com/post/" + widget.postid;
    dynamic dat = {
      "answers": [
        {
          "answer_id": widget.userid,
          "answerer_name": widget.username,
          "answer": val,
          "timestamp": DateTime.now().toString()
        }
      ]
    };
    try {
      await Dio().put(url,
          data: dat,
          options: Options(
              headers: {'Content-Type': 'application/json;charset=UTF-8'}));
    } catch (e) {
      print(e);
    }
    setState(() {
      val = "";
    });
  }

  List postlist;
  Future getpostdata() async {
    final String url =
        "https://fast-tor-93770.herokuapp.com/post/" + widget.postid;
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
          setState(() {
            postlist = value["post"]["answers"];
          }),
        });
  }

  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Answers',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: postlist != null
            ? Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (postlist.length == 0)
                            return Center(
                                child: Container(
                                    child: Text("✴️ No Answers ✴️",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 30))));
                          return Container(
                              margin: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 40,
                                          child: Text(
                                            postlist[index]["answerer_name"][0],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.brown,
                                            borderRadius:
                                                BorderRadius.circular(120),
                                          )),
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                              postlist[index]['answerer_name'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white))),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 10, left: 5, right: 5),
                                      child: Text(
                                        postlist[index]['answer'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 0.4,
                                    ),
                                  ),
                                ],
                              ));
                        })),
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                        child: TextField(
                          minLines: 1,
                          maxLines: 3,
                          controller: _controller,
                          style: TextStyle(color: Colors.white),
                          onChanged: (text) {
                            setState(() {
                              val = text;
                            });
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    if (val == "") {
                                    } else {
                                      _showMyDialog();
                                      postdata().then((value) => {
                                            this.getpostdata().then((value) => {
                                                  setState(() {
                                                    postlist = value["post"]
                                                        ["answers"];
                                                  }),
                                                }),
                                            Navigator.pop(context)
                                          });
                                    }
                                    _controller.clear();
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  )),
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: 'Post answer'),
                        )),
                  ],
                )
              ])
            : Center(child: CircularProgressIndicator()));
  }
}
