import 'package:flutter/material.dart';


class Watchlistmovies extends StatefulWidget {
  Watchlistmovies({Key key}) : super(key: key);

  @override
  _WatchlistmoviesState createState() => _WatchlistmoviesState();
}

class _WatchlistmoviesState extends State<Watchlistmovies> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Watchlist name',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (100.0 / 120.0),
                ),
                shrinkWrap: true,
                itemCount: 6,
                controller: ScrollController(keepScrollOffset: false),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(5.3),
                        child: Container(
                            height: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR28i5jWF37DvM01csPLTUTxEvCUAiL1ho6qw&usqp=CAU"),
                                ))),
                      ));
                })));
  }
}
