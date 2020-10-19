import 'package:flutter/material.dart';

class BurbleChat extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const BurbleChat(
      {Key key,
      @required this.texto,
      @required this.uid,
      @required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animationController,
        child: SizeTransition(
          sizeFactor: CurvedAnimation(
              parent: animationController, curve: Curves.easeOut),
          child: Container(
              child: this.uid == '123' ? _myMessage() : _noMyMessage()),
        ));
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 8, right: 10, left: 50),
        child: Text(
          this.texto,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Color(0xff4D9EF6), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _noMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 8, right: 50, left: 10),
        child: Text(
          this.texto,
          style: TextStyle(color: Colors.black),
        ),
        decoration: BoxDecoration(
            color: Colors.blueGrey[300],
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
