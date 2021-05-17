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
                              height: 159,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(153, 163, 164, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          fit: BoxFit.fitWidth,
                                          image:
                                              AssetImage("images/loading.png"),
                                        )),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 0,
                                      child: Icon(Icons.more_vert,
                                          color: Colors.black)),
                                  Positioned(
                                      bottom: 10,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(
                                            watchlist[index]['watchlistname'] ==
                                                    null
                                                ? ""
                                                : watchlist[index]
                                                    ['watchlistname'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 27)),
                                      )),
                                ],
                              )));
                    }),
              ));
  }
}
