import 'package:flutter/material.dart';
import 'package:flutter_chat/globals/environtment.dart';
import 'package:flutter_chat/models/mensajes_response.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/models/usuario.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioToWrite;

  Future<List<Message>> getChat(String usuarioId) async {
    final resp = await http.get('${Environment.apiUrl}/messages/$usuarioId',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        });

    final mensajesResponse = mensajesResponseFromJson(resp.body);

    return mensajesResponse.messages;
  }
}
