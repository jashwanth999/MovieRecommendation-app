import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  Error({Key key}) : super(key: key);

  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xffd8f3dc),
      body: Stack(
        children: [
          Positioned(
            top: 24,
            bottom: 200,
            left: 24,
            right: 24,
            child: Container(
              child: Image.asset('images/loading.png'),
            ),
          ),
          Positioned(
            top: 150,
            bottom: 0,
            left: 24,
            right: 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                const Text(
                  '404',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      letterSpacing: 2,
                      color: const Color(0xff2f3640),
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Sorry, we couldn\'t find the page!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: const Color(0xff2f3640),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
