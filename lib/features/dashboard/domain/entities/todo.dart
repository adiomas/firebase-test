import 'package:equatable/equatable.dart';
import 'package:firebase_test/common/utils/converters/date_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Todo extends Equatable {
  final String? id;
  final String userId;
  final String? title;
  final String? description;
  final bool isCompleted;
  @DateConverter()
  final DateTime? createdAt;

  const Todo({
    this.id,
    required this.userId,
    this.title,
    this.description,
    required this.isCompleted,
    this.createdAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  factory Todo.fromJsonForSupabase(Map<String, dynamic> json) => Todo(
        id: json['id']?.toString(),
        userId: json['user_id'] as String,
        title: json['title'] as String?,
        description: json['description'] as String?,
        isCompleted: json['is_completed'] as bool,
      );

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Map<String, dynamic> toJsonForSupabase() => {
        'title': title,
        'description': description,
        'is_completed': isCompleted,
      };

  Todo copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, userId, title, description, isCompleted, createdAt];
}
