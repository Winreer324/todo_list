import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_entity.freezed.dart';

part 'task_entity.g.dart';

@freezed
class TaskEntity with _$TaskEntity {
  factory TaskEntity({
    required int id,
    required int categoryId,
    required String name,
    String? description,
    DateTime? dateStart,
    DateTime? dateEnd,
    @JsonKey(defaultValue: false) @Default(false) bool isComplete,
  }) = _TaskEntity;

  @override
  // factory TaskEntity.fromJson(Map<String, dynamic> json) => _$TaskEntityFromJson(json);
  factory TaskEntity.fromJson(Map<String, dynamic> json) => TaskEntity(
        id: json['id'],
        categoryId: json['categoryId'],
        name: json['name'],
        description: json['description'],
        dateStart: json['dateStart'] == null ? null : DateTime.parse(json['dateStart'] as String),
        dateEnd: json['dateEnd'] == null ? null : DateTime.parse(json['dateEnd'] as String),
        isComplete: _parseComplete(json['isComplete']),
      );

  static bool completeFromJson(dynamic text) {
    if (text == '1') return true;
    return false;
  }

  static String completeToJson(bool isComplete) {
    return jsonEncode(isComplete);
  }

  static bool _parseComplete(Object value) {
    if (value is int) {
      return value == 1;
    }
    if (value is String) {
      return value == '1';
    }

    return false;
  }
}

/// int id
/// int categoryId
/// String name
/// String description
/// DateTime dateStart
/// DateTime dateEnd
/// bool isComplete
