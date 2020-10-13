import 'package:flutter/material.dart';

import 'package:flutter_chat/pages/chat_pages.dart';
import 'package:flutter_chat/pages/loading_pages.dart';
import 'package:flutter_chat/pages/login_pages.dart';
import 'package:flutter_chat/pages/register_pages.dart';
import 'package:flutter_chat/pages/usuarios_pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'loading': (_) => LoadingPage(),
  'register': (_) => RegisterPage()
};
