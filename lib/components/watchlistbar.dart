import 'package:flutter/material.dart';
import 'package:flutter_app/components/wachlist/Saved.dart';
import 'package:flutter_app/movie/watchlist.dart';
import 'package:shimmer/shimmer.dart';

class Watchlistbar extends StatefulWidget {
  final id;
  final username;
  Watchlistbar({Key key, @required this.id, this.username}) : super(key: key);

  @override
  _WatchlistbarState createState() => _WatchlistbarState();
}

class _WatchlistbarState extends State<Watchlistbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.black,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.pink, width: 3.0),
                      ),
                    ),
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Shimmer.fromColors(
                              period: Duration(milliseconds: 2000),
                              baseColor: Colors.grey[500],
                              direction: ShimmerDirection.ltr,
                              highlightColor: Colors.grey[300],
                              child: Text(
                                "WATCHLIST",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ))),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Shimmer.fromColors(
                            period: Duration(milliseconds: 2000),
                            baseColor: Colors.grey[500],
                            direction: ShimmerDirection.ltr,
                            highlightColor: Colors.grey[300],
                            child: Text(
                              "SAVED",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Watchlist(id: widget.id, username: widget.username),
            Saved(userid: widget.id, username: widget.username)
          ],
        ),
      ),
    );
  }
}
