import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/domain/entity/task_entity.dart';

part 'add_task_event.freezed.dart';

@freezed
abstract class AddTaskEvent with _$AddTaskEvent {
  const factory AddTaskEvent.nameChanged({String? name}) = AddTaskNameChanged;

  const factory AddTaskEvent.nameDescriptionChanged({String? description}) = AddTaskNameDescriptionChanged;

  const factory AddTaskEvent.nameDateStartChanged({DateTime? dateTime}) = AddTaskNameDateStartChanged;

  const factory AddTaskEvent.nameDateEndChanged({DateTime? dateTime}) = AddTaskNameDateEndChanged;

  const factory AddTaskEvent.saveClicked() = AddTaskSaveClicked;

  const factory AddTaskEvent.exitClicked() = AddTaskExitClicked;
}

/// int id
/// int categoryId
/// String name
/// String description
/// DateTime dateStart
/// DateTime dateEnd
/// bool isComplete
