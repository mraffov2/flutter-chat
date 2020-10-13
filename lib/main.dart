import 'package:flutter/material.dart';
import 'package:flutter_chat/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}
