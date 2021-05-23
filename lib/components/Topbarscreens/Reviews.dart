import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Reviews extends StatefulWidget {
  final id;
  final moviename;
  Reviews({Key key, @required this.id, this.moviename}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List reviews;
  void getpopularresponse() async {
    var response = await Dio()
        .get("http://movie-bj-9.herokuapp.com/getreview/" + widget.moviename);
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          reviews = data;
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

  Widget build(BuildContext context) {
    if (reviews == null) return Center(child: CircularProgressIndicator());
    if (reviews.length == 0)
      return Center(
          child: Container(
              child: Text("✴️ No Reviews ✴️",
                  style: TextStyle(color: Colors.white, fontSize: 30))));
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          reviews[index]["review"],
                          maxLines: 12,
                          style: TextStyle(
                            fontFamily: 'fonts/Lato-Bold.ttf',
                            decoration: TextDecoration.none,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 4, bottom: 5),
                        child: Text(
                            (reviews[index]['rating'] == "Good"
                                    ? "👍  "
                                    : "👎  ") +
                                reviews[index]['rating'],
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.8,
                        ),
                      ),
                    ],
                  ));
            }));
  }
}
