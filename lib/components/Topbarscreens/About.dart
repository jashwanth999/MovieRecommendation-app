import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/casts/Castdetails.dart';

class About extends StatefulWidget {
  final overview;
  final id;
  final moviename;
  final userid;
  final username;
  About(
      {Key key,
      @required this.overview,
      this.id,
      this.moviename,
      this.userid,
      this.username})
      : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  List genres;
  List moviedetails;
  List director;
  List crew;

  void getmoviedetails() async {
    try {
      var response = await Dio()
          .get("http://movie-bj-9.herokuapp.com/getmovie/" + widget.moviename);
      var data = response.data;

      setState(() {
        moviedetails = data;
      });
    } catch (e) {}
  }

  void getpopularresponse() async {
    var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
        widget.id.toString() +
        "?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US");
    var data = response.data;
    try {
      setState(() {
        genres = data["genres"];
      });
    } catch (e) {
      print(e);
    }
  }

  void getcrewdetails() async {
    var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
        widget.id.toString() +
        "/credits?api_key=8b5da40bcd2b5fa4afe55c468001ad8a");
    var data = response.data;
    try {
      setState(() {
        crew = data["cast"];
      });
    } catch (e) {
      print(e);
    }
  }

  void getdirector() async {
    var response = await Dio()
        .get("http://movie-bj-9.herokuapp.com/getdirector/" + widget.moviename);
    var data = response.data;
    try {
      setState(() {
        director = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    this.getpopularresponse();
    this.getmoviedetails();
    this.getdirector();
    this.getcrewdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getoverview(),
            Container(
                margin: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
                child: Text(
                  widget.overview,
                  style: TextStyle(
                      fontFamily: 'fonts/Lato-Bold.ttf',
                      color: Colors.grey[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                )),
            getgenrehead(),
            getgenres(),
            getdetails(),
            getdetailslist(),
            getcrewname(),
            getcrew()
          ],
        )));
  }

  Widget getcrew() {
    if (crew == null) return Center(child: CircularProgressIndicator());
    if (crew.length == 0)
      return Center(
          child: Container(
        child: Text(
          "NO CREW DETAILS AVAILABLE",
          style: TextStyle(color: Colors.white),
        ),
      ));
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: 150,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: crew.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Castdetails(
                                  castname: crew[index]['name'],
                                  castid: crew[index]['id'],
                                  userid: widget.userid,
                                  username: widget.username,
                                  profilepath: crew[index]['profile_path'],
                                )));
                  },
                  child: Container(
                      width: 100,
                      margin: EdgeInsets.all(3),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 120,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(crew[index]
                                                ["profile_path"] ==
                                            null
                                        ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR28i5jWF37DvM01csPLTUTxEvCUAiL1ho6qw&usqp=CAU"
                                        : "https://image.tmdb.org/t/p/original" +
                                            crew[index]["profile_path"]),
                                  ))),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                      crew[index]["original_name"]
                                                  .split(" ")[0] ==
                                              null
                                          ? ""
                                          : crew[index]["original_name"]
                                              .split(" ")[0],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))))
                        ],
                      )));
            }));
  }

  Widget getdetailslist() {
    if (moviedetails == null || director == null)
      return Container(
          height: 200, child: Center(child: CircularProgressIndicator()));
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text("Director: " + (director == null ? "" : director[0]),
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 19,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                  moviedetails[0]['runtime'].toString() == null
                      ? "Run time: " + "NO data"
                      : "Run time: " +
                          moviedetails[0]['runtime'].toString() +
                          "m",
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 19,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                  moviedetails[0]['release_date'].toString() == null
                      ? "Release Date: " + "NO data"
                      : "Release Date: " + moviedetails[0]['release_date'],
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 19,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                  moviedetails[0]['popularity'].toString() == null
                      ? "popularity: " + "NO data"
                      : "popularity: " +
                          moviedetails[0]['popularity'].toString(),
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 19,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }

  Widget getdetails() {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        left: 8,
      ),
      child: Text("DETAILS",
          style: TextStyle(
              color: Color.fromRGBO(222, 49, 99, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  Widget getcrewname() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 8, bottom: 5),
      child: Text("CREW",
          style: TextStyle(
              color: Color.fromRGBO(222, 49, 99, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  Widget getoverview() {
    return Container(
      margin: EdgeInsets.only(
        top: 3,
        left: 8,
      ),
      child: Text("OVERVIEW",
          style: TextStyle(
              color: Color.fromRGBO(222, 49, 99, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  Widget getgenrehead() {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 8),
      child: Text("GENRES",
          style: TextStyle(
              fontFamily: 'fonts/Lato-Bold.ttf',
              color: Color.fromRGBO(222, 49, 99, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)),
    );
  }

  Widget getgenres() {
    if (genres == null)
      return Container(
        height: 50,
        child: Center(child: CircularProgressIndicator()),
      );

    return Container(
        height: 50.0,
        margin: EdgeInsets.only(top: 8),
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(
                            2.0,
                            2.0,
                          ),
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: Text(genres[index]['name'],
                        style: TextStyle(
                            fontFamily: 'fonts/Lato-Bold.ttf',
                            color: Colors.black,
                            fontSize: 18,
                            decoration: TextDecoration.none)),
                  ));
            }));
  }
}
