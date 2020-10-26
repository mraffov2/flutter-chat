import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_chat/routes/routes.dart';
import 'package:flutter_chat/services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat app',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
