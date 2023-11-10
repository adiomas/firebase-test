// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      isCompleted: json['is_completed'] as bool,
      createdAt: _$JsonConverterFromJson<String, DateTime>(
          json['created_at'], const DateConverter().fromJson),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'is_completed': instance.isCompleted,
      'created_at': _$JsonConverterToJson<String, DateTime>(
          instance.createdAt, const DateConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
