// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  final String name;
  final String email;
  final String phone;
  final String description;

  Chat({
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
  });

  Chat copyWith({
    String? name,
    String? email,
    String? phone,
    String? description,
  }) =>
      Chat(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        description: description ?? this.description,
      );

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "description": description,
  };
}
