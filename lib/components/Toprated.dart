import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/navigations/Topbar.dart';

class Toprated extends StatefulWidget {
  Toprated({Key key}) : super(key: key);

  @override
  _TopratedState createState() => _TopratedState();
}

class _TopratedState extends State<Toprated> {
  List val;
  Future getresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=8b5da40bcd2b5fa4afe55c468001ad8a");
    var data = response.data;
    try {
      setState(() {
        val = data["results"];
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
    if (val == null)
      return Container(
          height: 160, child: Center(child: CircularProgressIndicator()));
    else
      return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          height: 160.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: val.length != null ? val.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Topbar(
                                    moviename: val[index]["title"],
                                  )));
                    },
                    child: Container(
                        width: 110,
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0.0)),
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 145,
                                width: 130,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: FadeInImage.assetNetwork(
                                      image: "https://image.tmdb.org/t/p/w500" +
                                          val[index]["poster_path"],
                                      placeholder: "images/loading.png",
                                      fit: BoxFit.cover,
                                    ))),
                            Positioned(
                                top: 3,
                                right: 0,
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                )),
                          ],
                        )));
              }));
  }
}
