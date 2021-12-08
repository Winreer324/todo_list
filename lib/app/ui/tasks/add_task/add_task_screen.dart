import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/helpers/enums/input_fields.dart';
import 'package:todo_list/app/resources/resources.dart';
import 'package:todo_list/app/ui/tasks/add_task/bloc/add_task_bloc.dart';
import 'package:todo_list/app/ui/tasks/add_task/widgets/app_text_field_form.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New task'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          BlocBuilder<AddTaskBloc, AddTaskState>(
            // buildWhen: (previous, current) =>
            // (previous is AddTaskValidation && current is AddTaskValidation) ? previous.name != current.name ||
            //     current.inputErrors!.isNotEmpty : false,
            builder: (context, state) {
              return AppTextFieldForm(
                labelText: 'Title',
                errorText: _setErrorText(state, InputFields.name),
                onChanged: (value) => context.read<AddTaskBloc>().add(AddTaskEvent.nameChanged(name: value)),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          AppTextFieldForm(
            labelText: 'Description',
            onChanged: (value) =>
                context.read<AddTaskBloc>().add(
                  AddTaskEvent.nameDescriptionChanged(description: value),
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AddTaskBloc, AddTaskState>(
            buildWhen: (previous, current) =>
            (previous is AddTaskValidation && current is AddTaskValidation)
                ? previous.dateStart != current.dateStart
                : false,
            builder: (context, state) {
              final DateTime? currentDateTime = state is AddTaskValidation ? state.dateStart : DateTime.now();

              return InkWell(
                onTap: () async {
                  final DateTime? dateTime = await _showPicker(context, oldDateTime: currentDateTime);
                  if (dateTime != null) {
                    context.read<AddTaskBloc>().add(AddTaskEvent.nameDateStartChanged(dateTime: dateTime));
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGray, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child:
                    Text(currentDateTime != null ? _dateFormat.format(currentDateTime) : 'Выберете время начала'),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AddTaskBloc, AddTaskState>(
            buildWhen: (previous, current) =>
            (previous is AddTaskValidation && current is AddTaskValidation)
                ? previous.dateEnd != current.dateEnd
                : false,
            builder: (context, state) {
              final DateTime? currentDateTime = state is AddTaskValidation ? state.dateEnd : DateTime.now();

              return InkWell(
                onTap: () async {
                  final DateTime? dateTime = await _showPicker(context, oldDateTime: currentDateTime);
                  if (dateTime != null) {
                    context.read<AddTaskBloc>().add(AddTaskEvent.nameDateEndChanged(dateTime: dateTime));
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGray, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(currentDateTime != null ? _dateFormat.format(currentDateTime) : 'Выберете время конца'),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(onPressed: () {
              context.read<AddTaskBloc>().add(const AddTaskEvent.saveClicked());
            }, child: const Text('save')),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _showPicker(BuildContext context, {DateTime? oldDateTime}) async {
    final DateTime now = DateTime.now();
    DateTime? dateTime = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(
        now.year,
        now.month + 1,
        now.day,
        now.hour,
      ),
      initialDate: oldDateTime ?? now,
    );

    if (dateTime != null) {
      final TimeOfDay? hourAndMinuteTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      );
      if (hourAndMinuteTime != null) {
        dateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          hourAndMinuteTime.hour,
          hourAndMinuteTime.minute,
        );
      }
    }

    return dateTime;
  }

  String? _setErrorText(AddTaskState state, InputFields field) {
    if (state is AddTaskValidation) {
      if (state.inputErrors?.any((element) => element.field == field) ?? false) {
        return state.inputErrors!.firstWhere((element) => element.field == field).errorMessage;
      }
      return null;
    }
  }
}
