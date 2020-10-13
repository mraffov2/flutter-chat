import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final String urlImage;
  final String title;

  const CustomLogo({Key key, @required this.urlImage, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            //Image(image: AssetImage('assets/tag-logo.png')),
            Image(image: AssetImage(this.urlImage)),
            SizedBox(height: 20),
            Text(
              this.title,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
