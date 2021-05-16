import 'package:flutter/material.dart';
import 'package:flutter_app/components/wachlist/Createplaylist.dart';
import 'package:flutter_app/components/wachlist/watchlistmovies.dart';
import 'package:dio/dio.dart';

class Watchlist extends StatefulWidget {
  final id;
  final username;
  Watchlist({Key key, @required this.username, this.id}) : super(key: key);
  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  List watchlist;
  Future getpostdata() async {
    final String url =
        "https://fast-tor-93770.herokuapp.com/watch/" + widget.id;
    try {
      var response = await Dio().get(url);
      return response.data['post'];
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
                watchlist = value[0]['watchlist'];
              }),
            }
        });
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
            'Watch List',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Createplaylist(
                        userid: widget.id, username: widget.username)));
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.pink,
        ),
        body: watchlist == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                    itemCount: watchlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Watchlistmovies()));
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      height: 60,
                                      width: 60,
                                      color: Colors.black,
                                      child: Text("🍟",
                                          style: TextStyle(fontSize: 40))),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                        watchlist[index]['watchlistname'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23)),
                                  )
                                ],
                              )));
                    }),
              ));
  }
}
