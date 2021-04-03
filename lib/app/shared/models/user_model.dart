import 'dart:convert';

class UserModel {
  final String name;
  final String accessToken;

  UserModel({
    this.name,
    this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'access_token': accessToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      accessToken: map['access_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String name,
    String accessToken,
  }) {
    return UserModel(
      name: name ?? this.name,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
