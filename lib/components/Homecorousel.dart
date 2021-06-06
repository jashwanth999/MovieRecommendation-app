import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/navigations/Topbar.dart';
import 'package:shimmer/shimmer.dart';

class Homecorousel extends StatefulWidget {
  Homecorousel({Key key}) : super(key: key);

  @override
  _HomecorouselState createState() => _HomecorouselState();
}

class _HomecorouselState extends State<Homecorousel> {
  List val;
  Future getresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/trending/all/day?api_key=360a9b5e0dea438bac3f653b0e73af47");
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
          height: MediaQuery.of(context).size.height * 0.38,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Shimmer.fromColors(
              period: Duration(milliseconds: 2000),
              baseColor: Colors.grey[500],
              direction: ShimmerDirection.ltr,
              highlightColor: Colors.grey[300],
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              )));
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: MediaQuery.of(context).size.height * 0.38,
        child: Carousel(
          autoplayDuration: Duration(seconds: 3),
          autoplay: true,
          images: [
            Stack(
              children: [
                GestureDetector(
                    onTap: () async {
                      if (val[1]["original_title"] == null) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Topbar(
                                      moviename: val[1]["original_title"],
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 30, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                image: "https://image.tmdb.org/t/p/original" +
                                    val[1]['poster_path'],
                                placeholder: "images/loading.png",
                              ))),
                    )),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                        child: Text(
                      val[1]["original_title"] == null
                          ? ""
                          : val[1]["original_title"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )))
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                    onTap: () async {
                      if (val[2]["original_title"] == null) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Topbar(
                                      moviename: val[2]["original_title"],
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 30, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                image: "https://image.tmdb.org/t/p/original" +
                                    val[2]['poster_path'],
                                placeholder: "images/loading.png",
                              ))),
                    )),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                        child: Text(
                      val[2]["original_title"] == null
                          ? ""
                          : val[2]["original_title"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )))
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                    onTap: () async {
                      if (val[3]["original_title"] == null) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Topbar(
                                      moviename: val[3]["original_title"],
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 30, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                image: "https://image.tmdb.org/t/p/original" +
                                    val[3]['poster_path'],
                                placeholder: "images/loading.png",
                              ))),
                    )),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                        child: Text(
                      val[3]["original_title"] == null
                          ? ""
                          : val[3]["original_title"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )))
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                    onTap: () async {
                      if (val[4]["original_title"] == null) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Topbar(
                                      moviename: val[4]["original_title"],
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 30, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                image: "https://image.tmdb.org/t/p/original" +
                                    val[4]['poster_path'],
                                placeholder: "images/loading.png",
                              ))),
                    )),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                        child: Text(
                      val[4]["original_title"] == null
                          ? ""
                          : val[4]["original_title"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )))
              ],
            )

            /*GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Topbar(
                              moviename: val[5]["original_title"],
                            )));
              },
              child: Image(
                fit: BoxFit.fitWidth,
                image: NetworkImage("https://image.tmdb.org/t/p/original" +
                    val[5]["poster_path"]),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Topbar(
                              moviename: val[6]["original_title"],
                            )));
              },
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage("https://image.tmdb.org/t/p/original" +
                    val[6]["backdrop_path"]),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Topbar(
                              moviename: val[4]["original_title"],
                            )));
              },
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage("https://image.tmdb.org/t/p/original" +
                    val[4]["backdrop_path"]),
              ),
            ),*/
          ],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.lightGreenAccent,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.white.withOpacity(0.0),
        ));
  }
}
