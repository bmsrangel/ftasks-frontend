import 'dart:convert';

class TodoModel {
  final int id;
  final String description;
  final bool isCompleted;

  TodoModel({
    this.id,
    this.description,
    this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      description: map['description'],
      isCompleted: map['isCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));

  TodoModel copyWith({
    int id,
    String description,
    bool isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
