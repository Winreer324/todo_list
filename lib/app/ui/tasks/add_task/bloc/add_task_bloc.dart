import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo_list/app/helpers/enums/input_fields.dart';
import 'package:todo_list/app/helpers/input_errors/input_error_model.dart';

import 'add_task_event.dart';
import 'add_task_state.dart';

export 'add_task_event.dart';
export 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskState.validation(inputErrors: []));

  String? _name;
  String? _description;
  DateTime? _dateStart;
  DateTime? _dateEnd;
  bool _hasErrors = false;

  @override
  Stream<AddTaskState> mapEventToState(AddTaskEvent event) async* {
    final currentState = state;
    yield* event.when(
      exitClicked: () => _mapExitClicked(),
      saveClicked: () => _mapSaveClicked(),
      nameChanged: (value) => _mapNameChanged(currentState: currentState, value: value),
      nameDescriptionChanged: (value) => _mapDescriptionChanged(value: value),
      nameDateStartChanged: (dateTime) => _mapDateStartChanged(currentState: currentState, dateTime: dateTime),
      nameDateEndChanged: (dateTime) => _mapDateEndChanged(currentState: currentState, dateTime: dateTime),
    );
  }

  Stream<AddTaskState> _mapExitClicked() async* {}

  Stream<AddTaskState> _mapSaveClicked() async* {
    yield* _validateFields();
  }

  Stream<AddTaskState> _mapNameChanged({required AddTaskState currentState, String? value}) async* {
    _name = value;
    // final List<InputErrorModel> _inputErrors = _inputErrorsInState(currentState);
    // if (currentState is AddTaskValidation) {
    //   yield currentState.copyWith(inputErrors: _inputErrors, name: value);
    // } else {
    //   yield AddTaskState.validation(inputErrors: _inputErrors);
    // }
  }

  Stream<AddTaskState> _mapDescriptionChanged({String? value}) async* {
    _description = value;
  }

  Stream<AddTaskState> _mapDateStartChanged({required AddTaskState currentState, DateTime? dateTime}) async* {
    _dateStart = dateTime;
    final List<InputErrorModel> _inputErrors = _inputErrorsInState(currentState);
    if (currentState is AddTaskValidation) {
      yield currentState.copyWith(inputErrors: _inputErrors, dateStart: dateTime);
    } else {
      yield AddTaskState.validation(inputErrors: _inputErrors, dateStart: dateTime);
    }
  }

  Stream<AddTaskState> _mapDateEndChanged({required AddTaskState currentState, DateTime? dateTime}) async* {
    _dateEnd = dateTime;
    final List<InputErrorModel> _inputErrors = _inputErrorsInState(currentState);
    if (currentState is AddTaskValidation) {
      yield currentState.copyWith(inputErrors: _inputErrors, dateEnd: dateTime);
    } else {
      yield AddTaskState.validation(inputErrors: _inputErrors, dateEnd: dateTime);
    }
  }

  Stream<AddTaskState> _validateFields() async* {
    List<InputErrorModel> errorsList = [];

    _validateStringField(InputFields.name, _name, errorsList);
    _validateNullField(InputFields.dateStart, _dateStart, errorsList);
    _validateNullField(InputFields.dateEnd, _dateEnd, errorsList);

    if (errorsList.isEmpty) {
      _hasErrors = false;
      yield const AddTaskState.save();
    } else {
      _hasErrors = true;
      yield AddTaskState.validation(inputErrors: errorsList);
    }
  }

  InputErrorModel? _validateStringField(
    InputFields field,
    String? value,
    List<InputErrorModel> errorsList,
  ) {
    if (value == null || value.trim().isEmpty) {
      final error = InputErrorModel(field: field, errorMessage: 'Поле не должно быть пустым');
      errorsList.add(error);
      return error;
    }
  }

  InputErrorModel? _validateNullField(
    InputFields field,
    Object? value,
    List<InputErrorModel> errorsList,
  ) {
    if (value == null) {
      return InputErrorModel(field: field, errorMessage: '');
    }
  }

  List<InputErrorModel> _inputErrorsInState(AddTaskState currentState) =>
      currentState is AddTaskValidation ? currentState.inputErrors ?? [] : [];
}
