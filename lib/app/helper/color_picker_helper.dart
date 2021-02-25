import 'package:flutter/material.dart';

Color colorPicker(type, number) {
  if (type == 'SYS') {
    if (number <= 90) return Colors.deepPurple;
    if (number > 90 && number <= 120) return Colors.green;
    if (number > 120 && number <= 140) return Colors.amber;
    if (number > 140) return Colors.red;
  } else if (type == 'DIA') {
    if (number <= 60) return Colors.deepPurple;
    if (number > 60 && number <= 90) return Colors.green;
    if (number > 90 && number <= 100) return Colors.amber;
    if (number > 100) return Colors.red;
  }

  return Colors.red;
}
