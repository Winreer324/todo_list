import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/app/ui/tasks/bloc/task_bloc.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) => state.maybeWhen(
        success: (tasks, _, __) => ListView.builder(
          itemCount: tasks.length,
          shrinkWrap: true,
          padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(tasks[index].name.toString()),
            );
          },
        ),
        orElse: () => const SizedBox(),
      ),
    );
  }
}
