import 'package:flutter/material.dart';
import 'package:todo_list/app/resources/resources.dart';

class AppTextFieldForm extends StatelessWidget {
  final Function()? onTap;
  final Function(String?)? onChanged;

  final String? hintText;
  final String? errorText;
  final Widget? label;
  final String? labelText;

  const AppTextFieldForm({
    Key? key,
    this.onTap,
    this.onChanged,
    this.label,
    this.hintText,
    this.labelText,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        label: _setLabel(),
        errorMaxLines: 2,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGray),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGray),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.baseColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.baseColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        errorText: errorText,
      ),
    );
  }

  Widget? _setLabel() {
    if (label != null) {
      return label;
    }
    if (labelText != null) {
      return Text(
        labelText!,
      );
    }
  }
}
