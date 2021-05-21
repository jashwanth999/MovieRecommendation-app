import 'package:flutter/material.dart';
import 'package:flutter_app/navigations/Topbar.dart';
import 'package:dio/dio.dart';

class Genres extends StatefulWidget {
  final userid;
  final id;
  final genrename;
  final username;
  Genres(
      {Key key, @required this.id, this.genrename, this.userid, this.username})
      : super(key: key);

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  List popularlist;
  void getpopularresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/discover/movie?api_key=360a9b5e0dea438bac3f653b0e73af47&with_genres=" +
            widget.id.toString());
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          popularlist = data["results"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getpopularresponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.genrename,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [getallpopularmoviecard()],
          ),
        )
        //AppB
        );
  }

  Widget getallpopularmoviecard() {
    if (popularlist == null)
      return Center(child: CircularProgressIndicator());
    else
      return Container(
          margin: EdgeInsets.all(4.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (115.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: popularlist != null ? popularlist.length : 0,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Topbar(
                                            moviename: popularlist[index]
                                                ["title"],
                                            userid: widget.userid,
                                            username: widget.username,
                                          )));
                            },
                            child: Container(
                                height: 170,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: FadeInImage.assetNetwork(
                                    image: "https://image.tmdb.org/t/p/w500" +
                                        popularlist[index]["poster_path"],
                                    placeholder: "images/loading.png",
                                    fit: BoxFit.cover,
                                  ),
                                ))),
                        Positioned(
                            top: 3,
                            right: 0,
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )),
                      ],
                    ));
              }));
  }
}
