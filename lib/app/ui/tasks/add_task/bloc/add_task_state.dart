import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/app/helpers/input_errors/input_error_model.dart';

part 'add_task_state.freezed.dart';

@freezed
abstract class AddTaskState with _$AddTaskState {
  const factory AddTaskState.initial() = AddTaskInitial;

  const factory AddTaskState.save() = AddTaskSave;

  const factory AddTaskState.close() = AddTaskClose;

  factory AddTaskState.validation({
    required List<InputErrorModel>? inputErrors,
    String? name,
    String? description,
    DateTime? dateStart,
    DateTime? dateEnd,
  }) = AddTaskValidation;
}
