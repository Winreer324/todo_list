import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/domain/entity/task_entity.dart';

part 'task_state.freezed.dart';

@freezed
abstract class TaskState with _$TaskState {
  const factory TaskState.initial() = TaskInitial;

  const factory TaskState.loading() = TaskLoading;

  const factory TaskState.openAddTask() = TaskOpenAddTask;

  factory TaskState.success({
    required List<TaskEntity> tasks,
    @Default(false) bool isPaginationLoading,
    @Default(false) bool isRefresh,
  }) = TaskSuccess;

  factory TaskState.error({String? title, String? description}) = TaskError;
}
