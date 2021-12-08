import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/app/ui/tasks/add_task/add_task_screen.dart';
import 'package:todo_list/app/ui/tasks/add_task/bloc/add_task_bloc.dart';
import 'package:todo_list/app/ui/tasks/bloc/task_bloc.dart';
import 'package:todo_list/app/ui/tasks/widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (BuildContext context, state) => state.maybeWhen(
          openAddTask: () => Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                  create: (context)=> AddTaskBloc(),
                  child: AddTaskScreen()),
            ),
          ),
          orElse: () => null,
        ),
        child: const TaskList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          context.read<TaskBloc>().add(
                // task: TaskEntity(
                //   name: 'test',
                //   categoryId: Random().nextInt(9999),
                //   id: Random().nextInt(9999),
                //   description: 'test',
                //   dateEnd: DateTime.now(),
                //   dateStart: DateTime.now(),
                // ),
                const TaskEvent.addClicked(),
              );
        },
      ),
    );
  }
}
