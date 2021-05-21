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
          height: 240,
          child: Shimmer.fromColors(
              period: Duration(milliseconds: 2000),
              baseColor: Colors.grey[500],
              direction: ShimmerDirection.ltr,
              highlightColor: Colors.grey[300],
              child: Container(color: Colors.grey)));
    return SizedBox(
        height: 240.0,
        width: double.infinity,
        child: Carousel(
          autoplayDuration: Duration(seconds: 3),
          autoplay: true,
          images: [
            GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Topbar(
                                moviename: val[3]["original_title"],
                              )));
                },
                child: Stack(children: [
                  Container(
                    height: double.infinity,
                    child: FadeInImage.assetNetwork(
                      image: "https://image.tmdb.org/t/p/w500" +
                          val[3]["backdrop_path"],
                      placeholder: "images/loading.png",
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                      bottom: 30,
                      left: 10,
                      child: Container(
                        child: Shimmer.fromColors(
                            period: Duration(milliseconds: 2000),
                            baseColor: Colors.grey[500],
                            direction: ShimmerDirection.ltr,
                            highlightColor: Colors.grey[300],
                            child: Text(
                              val[3]["original_title"] == null
                                  ? " "
                                  : val[3]["original_title"],
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'fonts/Lato-Bold.ttf'),
                            )),
                      )),
                ])),
            GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Topbar(
                                moviename: val[7]["original_title"],
                              )));
                },
                child: Stack(children: [
                  Container(
                    height: double.infinity,
                    child: FadeInImage.assetNetwork(
                      image: "https://image.tmdb.org/t/p/w500" +
                          val[7]["backdrop_path"],
                      placeholder: "images/loading.png",
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                      bottom: 30,
                      left: 10,
                      child: Container(
                        child: Shimmer.fromColors(
                            period: Duration(milliseconds: 2000),
                            baseColor: Colors.grey[500],
                            direction: ShimmerDirection.ltr,
                            highlightColor: Colors.grey[300],
                            child: Text(
                              val[7]["original_title"] == null
                                  ? " "
                                  : val[7]["original_title"],
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'fonts/Lato-Bold.ttf'),
                            )),
                      )),
                ])),
            GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Topbar(
                                moviename: val[6]["original_title"],
                              )));
                },
                child: Stack(children: [
                  Container(
                      height: double.infinity,
                      child: FadeInImage.assetNetwork(
                        image: "https://image.tmdb.org/t/p/w500" +
                            val[6]["backdrop_path"],
                        placeholder: "images/loading.png",
                        fit: BoxFit.fitHeight,
                        width: double.infinity,
                      )),
                  Positioned(
                      bottom: 30,
                      left: 10,
                      child: Container(
                        child: Shimmer.fromColors(
                            period: Duration(milliseconds: 2000),
                            baseColor: Colors.grey[500],
                            direction: ShimmerDirection.ltr,
                            highlightColor: Colors.grey[300],
                            child: Text(
                              val[6]["original_title"] == null
                                  ? " "
                                  : val[6]["original_title"],
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'fonts/Lato-Bold.ttf'),
                            )),
                      )),
                ])),
            GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Topbar(
                                moviename: val[5]["original_title"],
                              )));
                },
                child: Stack(children: [
                  Container(
                    height: double.infinity,
                    child: FadeInImage.assetNetwork(
                      image: "https://image.tmdb.org/t/p/w500" +
                          val[5]["backdrop_path"],
                      placeholder: "images/loading.png",
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                      bottom: 30,
                      left: 10,
                      child: Container(
                        child: Shimmer.fromColors(
                            period: Duration(milliseconds: 2000),
                            baseColor: Colors.grey[500],
                            direction: ShimmerDirection.ltr,
                            highlightColor: Colors.grey[500],
                            child: Text(
                              val[5]["original_title"] == null
                                  ? " "
                                  : val[5]["original_title"],
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'fonts/Lato-Bold.ttf'),
                            )),
                      )),
                ])),

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
                fit: BoxFit.fitHeight,
                image: NetworkImage("https://image.tmdb.org/t/p/original" +
                    val[5]["backdrop_path"]),
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
