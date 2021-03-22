import 'package:flutter/material.dart';

class RunEvent {
  RunEvent({this.kind = '', this.value, this.duration});

  String kind;
  Object value;
  int duration;

  Color get color {
    final regErr = RegExp(r'err|reject|throw', caseSensitive: false);
    final regData = RegExp(r'data|resolve', caseSensitive: false);

    if (regErr.hasMatch(kind)) return Colors.red;
    if (regData.hasMatch(kind)) return Colors.green;
    return null;
  }
}
