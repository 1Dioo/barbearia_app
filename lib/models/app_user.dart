/*
  Modelo que representa um usuário do sistema.

  Armazena informações como nome, email,
  senha, telefone e foto de perfil.

  Também possui métodos para converter
  os dados para Map e JSON, facilitando
  o armazenamento local.
*/

import 'dart:convert';

class AppUser {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String? avatarBase64;

  const AppUser({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.avatarBase64,
  });

  AppUser copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? avatarBase64,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      avatarBase64: avatarBase64 ?? this.avatarBase64,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'avatarBase64': avatarBase64,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      avatarBase64: map['avatarBase64'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory AppUser.fromJson(String source) {
    return AppUser.fromMap(jsonDecode(source) as Map<String, dynamic>);
  }
}
