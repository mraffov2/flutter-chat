import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_chat/routes/routes.dart';

import 'package:flutter_chat/services/chat_service.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/socket_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat app',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
