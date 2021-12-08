import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  Size get sizeScreen => MediaQuery.of(this).size;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
