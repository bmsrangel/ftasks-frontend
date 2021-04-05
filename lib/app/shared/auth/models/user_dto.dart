import 'dart:convert';

class UserDto {
  final String name;
  final String email;
  final String password;

  UserDto({
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source));
}
