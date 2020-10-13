import 'package:flutter/material.dart';

class LabelsLogin extends StatelessWidget {
  final String ruta;
  final String titleLabel;
  final String subTitleLabel;

  const LabelsLogin(
      {Key key,
      @required this.ruta,
      @required this.titleLabel,
      @required this.subTitleLabel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            this.subTitleLabel,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              this.titleLabel,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
          )
        ],
      ),
    );
  }
}
