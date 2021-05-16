import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/Search/Genres.dart';
import 'package:flutter_app/Search/searchnames.dart';

class Searchbar extends StatefulWidget {
  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  List val;
  List browse = [
    {
      "name": "top",
      "color": Colors.red,
    },
    {
      "name": "Bollywood",
      "color": Colors.blue,
    },
    {
      "name": "Folk",
      "color": Colors.green,
    },
    {
      "name": "Hip Hop",
      "color": Colors.yellow,
    },
    {
      "name": "top",
      "color": Colors.pink,
    },
    {
      "name": "Bollywood",
      "color": Colors.pinkAccent,
    },
    {
      "name": "Folk",
      "color": Colors.indigo,
    },
    {
      "name": "Hip Hop",
      "color": Colors.deepOrangeAccent,
    },
    {
      "name": "Hip Hop",
      "color": Colors.purple,
    },
    {
      "name": "top",
      "color": Colors.lightGreenAccent,
    },
    {
      "name": "Bollywood",
      "color": Colors.blueGrey,
    },
    {
      "name": "Folk",
      "color": Colors.green[200],
    },
    {
      "name": "Hip Hop",
      "color": Colors.tealAccent,
    },
    {
      "name": "top",
      "color": Colors.deepPurpleAccent,
    },
  ];
  Future getresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=8b5da40bcd2b5fa4afe55c468001ad8a&language=en-US");
    var data = response.data;
    try {
      setState(() {
        val = data["genres"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getresponse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          gethead(),
          getsearchbar(),
          //gettopgeneresname(),
          gettopgeneres(),
        ])));
  }

  Widget gethead() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(children: [
        Text("Search Movies",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            )),
      ]),
    );
  }

  Widget gettopgeneresname() {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 0),
      child: Column(children: [
        Text("Top generes",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ))
      ]),
    );
  }

  Widget getsearchbar() {
    return Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(8.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: TextField(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Searchnames()));
          },
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
        ));
  }

  Widget gettopgeneres() {
    if (val == null)
      return Center(child: CircularProgressIndicator());
    else
      return Container(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (140.0 / 60.0),
              ),
              shrinkWrap: true,
              itemCount: 14,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Genres(
                                    id: val[index]['id'],
                                    genrename: val[index]['name'],
                                  )));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(6.0),
                        margin: EdgeInsets.all(7.3),
                        decoration: BoxDecoration(
                          color: browse[index]['color'],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          child: Text(val[index]["name"],
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        )));
              }));
  }
}
