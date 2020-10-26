import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showModal(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: <Widget>[
                MaterialButton(
                    child: Text('Ok'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  }

  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: null,
                  onPressed: () => Navigator.pop(context))
            ],
          ));
}
