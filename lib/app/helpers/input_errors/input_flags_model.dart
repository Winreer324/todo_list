import '../enums/input_fields.dart';

// Используется для изменения соц.сетей
class InputWithFlagsModel {
  final InputFields field;
  final bool hasError;
  final bool isEmpty;
  final bool hasInitialValue;

  InputWithFlagsModel({
    required this.field,
    this.hasError = false,
    this.isEmpty = false,
    this.hasInitialValue = false,
  });
}
