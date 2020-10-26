import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_chat/models/login_response.dart';
import 'package:flutter_chat/globals/environtment.dart';
import 'package:flutter_chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _loadingAuth = false;
  bool _invalidCredencials = false;
  // bool _tokenVaild = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get loadingAuth => this._loadingAuth;
  set loadingAuth(bool value) {
    this._loadingAuth = value;
    notifyListeners();
  }

  bool get invalidCredencials => this._invalidCredencials;
  set invalidCredencials(bool value) {
    this._invalidCredencials = value;
    notifyListeners();
  }

  // bool get tokenVaild => this._tokenVaild;
  // set tokenVaild(bool value) {
  //   this._tokenVaild = value;
  //   notifyListeners();
  // }

  //Tokens' getters by stattic way
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<String> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future login(String email, String password) async {
    this.loadingAuth = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post('${Environment.apiUrl}/singin',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 201) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._setToken(loginResponse.token);
    }

    if (resp.statusCode == 404) {
      this.invalidCredencials = true;
      this.loadingAuth = false;
    }

    this.loadingAuth = false;
  }

  Future singUp(String name, String email, String password) async {
    this.loadingAuth = true;

    final data = {'name': name, 'email': email, 'password': password};

    final resp = await http.post('${Environment.apiUrl}/create_user',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 201) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._setToken(loginResponse.token);
    }

    if (resp.statusCode == 404 || resp.statusCode == 400) {
      this.invalidCredencials = true;
      this.loadingAuth = false;
    }

    this.loadingAuth = false;
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    final resp = await http.get('${Environment.apiUrl}/referesh-token',
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._setToken(loginResponse.token);
      return true;
    } else {
      this._removeToken();
      return false;
    }
  }

  Future _setToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future _removeToken() async {
    // Delete value
    return await _storage.delete(key: 'token');
  }
}
