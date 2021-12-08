import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

part 'category_entity.g.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  factory CategoryEntity({
    required int id,
    required String name,
    String? description,
    @JsonKey(defaultValue: 0) @Default(0) int countTasks,
  }) = _CategoryEntity;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => _$CategoryEntityFromJson(json);
}
