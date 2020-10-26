// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.online,
    this.id,
    this.email,
    this.name,
    this.registeredAt,
  });

  bool online;
  String id;
  String email;
  String name;
  DateTime registeredAt;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        registeredAt: DateTime.parse(json["registeredAt"]),
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "_id": id,
        "email": email,
        "name": name,
        "registeredAt": registeredAt.toIso8601String(),
      };
}
