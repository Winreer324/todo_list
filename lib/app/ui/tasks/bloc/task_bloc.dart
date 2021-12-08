import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo_list/domain/entity/task_entity.dart';
import 'package:todo_list/domain/gateway/task_gateway.dart';

import 'task_event.dart';
import 'task_state.dart';

export 'task_event.dart';
export 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskGateway<TaskEntity> taskGateway;

  TaskBloc({required this.taskGateway}) : super(const TaskState.initial());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    final currentState = state;
    yield* event.when(
      fetch: () => _mapTaskFetch(currentState: currentState),
      refresh: () => _mapTaskRefresh(currentState: currentState),
      itemClicked: (photo) => _mapTaskItemClicked(currentState: currentState, photo: photo),
      add: (task) => _mapTaskAdd(currentState: currentState, task: task),
      addClicked: () => _mapAddClicked(
        currentState: currentState,
      ),
    );
  }

  Stream<TaskState> _mapTaskFetch({
    required TaskState currentState,
  }) async* {
    yield* _fetchData(currentState: currentState);
  }

  Stream<TaskState> _mapAddClicked({
    required TaskState currentState,
  }) async* {
    yield const TaskState.openAddTask();
    List<TaskEntity> tasks = _getTasksInState(currentState);
    yield TaskState.success(tasks: tasks);
  }

  Stream<TaskState> _mapTaskItemClicked({
    required TaskState currentState,
    required TaskEntity photo,
  }) async* {
    if (currentState is TaskSuccess) {
      yield currentState.copyWith(
        tasks: currentState.tasks,
      );
    }
  }

  Stream<TaskState> _mapTaskRefresh({
    required TaskState currentState,
  }) async* {
    yield* _fetchData(currentState: currentState, isRefresh: true);
  }

  Stream<TaskState> _fetchData({required TaskState currentState, bool isRefresh = false}) async* {
    // int saveCurrentPage = _page;
    if (isRefresh) {
      _resetPagination();
    }

    List<TaskEntity> photos = _getTasksInState(currentState);

    if (photos.isEmpty) {
      yield const TaskState.loading();
    } else {
      if (currentState is TaskSuccess) {
        yield currentState.copyWith(
          tasks: photos,
          isPaginationLoading: true,
          isRefresh: isRefresh,
        );
      }
    }

    try {
      final tasks = await taskGateway.getAll();
      if (tasks.isNotEmpty) {
        if (tasks != photos) {
          photos.addAll(tasks);
        }
      }
      yield TaskState.success(tasks: photos, isPaginationLoading: false, isRefresh: false);
    } catch (_) {
      yield* _setError(currentState, isRefresh);
    }
  }

  Stream<TaskState> _setError(TaskState currentState, bool isRefresh, {bool loadInternetConnect = false}) async* {
    if (isRefresh) {
      // _page = saveCurrentPage;
    }

    // List<TaskEntity> photos = _getTasksInState(currentState);
    //
    // if (photos.isEmpty) {
    //   yield TaskState.error(loadInternetConnect: loadInternetConnect);
    // } else {
    //   if (!loadInternetConnect) {
    //     yield TaskState.success(photos: photos, isPaginationLoading: false, isRefresh: false);
    //   } else {
    //     if (photos.isEmpty) {
    //       yield TaskState.error(loadInternetConnect: loadInternetConnect);
    //     } else {
    //       yield TaskState.success(photos: photos, isPaginationLoading: false, isRefresh: false);
    //     }
    //   }
    // }
  }

  void _resetPagination() {
    // _page = 1;
    // _countOfPages = 1;
  }

  Stream<TaskState> _mapTaskAdd({required TaskState currentState, required TaskEntity task}) async* {
    List<TaskEntity> tasks = _getTasksInState(currentState);

    if (tasks.isEmpty) {
      yield const TaskState.loading();
    } else {
      if (currentState is TaskSuccess) {
        yield currentState.copyWith(
          tasks: tasks,
          isPaginationLoading: true,
          isRefresh: false,
        );
      }
    }

    final old = await taskGateway.add(task);
    print(old);
    final newTasks = await taskGateway.getAll();
    // if (newTasks.isNotEmpty) {
    //   if (tasks != newTasks) {
    //     tasks.addAll(newTasks);
    //   }
    // }
    tasks = newTasks;
    yield TaskState.success(tasks: tasks, isPaginationLoading: false, isRefresh: false);
  }

  List<TaskEntity> _getTasksInState(TaskState currentState) => currentState is TaskSuccess ? currentState.tasks : [];
}
