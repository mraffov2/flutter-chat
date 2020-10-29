import 'package:flutter_chat/models/usuarios_response.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_chat/globals/environtment.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get('${Environment.apiUrl}/users', headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.users;
    } catch (e) {
      return [];
    }
  }
}
