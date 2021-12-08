import '../enums/input_fields.dart';

class InputErrorModel {
  final InputFields field;
  final String errorMessage;

  InputErrorModel({required this.field, required this.errorMessage});
}
