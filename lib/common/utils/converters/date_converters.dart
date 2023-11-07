import 'package:json_annotation/json_annotation.dart';

class DateConverter implements JsonConverter<DateTime, String> {
  const DateConverter();

  @override
  DateTime fromJson(String data) => DateTime.parse(data);

  @override
  String toJson(DateTime data) => data.toIso8601String();
}
