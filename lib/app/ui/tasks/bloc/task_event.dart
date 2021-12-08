import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/domain/entity/task_entity.dart';

part 'task_event.freezed.dart';

@freezed
abstract class TaskEvent with _$TaskEvent {
  const factory TaskEvent.fetch() = _TaskFetch;

  const factory TaskEvent.refresh() = _TaskRefresh;

  const factory TaskEvent.addClicked() = _TaskAddClicked;

  const factory TaskEvent.add({required TaskEntity task}) = _TaskAdd;

  const factory TaskEvent.itemClicked({required TaskEntity task}) = _TaskItemClicked;
}
