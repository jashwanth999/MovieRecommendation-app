import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigations/Topbar.dart';

class Watchlistmovies extends StatefulWidget {
  final userid;
  final watchlistmovieid;
  final username;
  final watchlistname;
  Watchlistmovies(
      {Key key,
      @required this.userid,
      this.watchlistmovieid,
      this.username,
      this.watchlistname})
      : super(key: key);

  @override
  _WatchlistmoviesState createState() => _WatchlistmoviesState();
}

class _WatchlistmoviesState extends State<Watchlistmovies> {
  List watchlistmovies;
  Future getpostdata() async {
    final String url = "https://fast-tor-93770.herokuapp.com/watch/" +
        widget.userid +
        "/" +
        widget.watchlistmovieid;
    try {
      var response = await Dio().get(url);
      return response.data['post'];
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    this.getpostdata().then((value) => {
          if (mounted)
            {
              setState(() {
                watchlistmovies = value[0]['watchlistdata'];
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            widget.watchlistname.toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: watchlistmovies == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (74.0 / 120.0),
                    ),
                    shrinkWrap: true,
                    itemCount: watchlistmovies.length,
                    controller: ScrollController(keepScrollOffset: false),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Topbar(
                                      userid: widget.userid,
                                      username: widget.username,
                                      moviename: watchlistmovies[index]
                                          ["moviename"])));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4.0),
                            margin: EdgeInsets.all(5.3),
                            child: watchlistmovies[index]["poster_path"] == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage("images/loading.png"),
                                    ))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: FadeInImage.assetNetwork(
                                      image:
                                          "https://image.tmdb.org/t/p/original" +
                                              watchlistmovies[index]
                                                  ["poster_path"],
                                      placeholder: "images/loading.png",
                                      fit: BoxFit.cover,
                                    ))),
                      );
                    })));
  }
}
