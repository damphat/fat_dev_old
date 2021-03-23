import 'package:flutter/material.dart';

class RunEvent {
  RunEvent({this.kind = 'event', this.value, this.duration});

  String kind;
  Object? value;
  int? duration;

  Color get color {
    final regErr = RegExp(r'err|reject|throw', caseSensitive: false);
    final regData = RegExp(r'return|data|resolve|done', caseSensitive: false);

    if (regErr.hasMatch(kind)) return Colors.red;
    if (regData.hasMatch(kind)) return Colors.green;
    return Colors.black;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! RunEvent) return false;
    return (kind == other.kind) &&
        (duration == other.duration) &&
        (value == other.value);
  }

  @override
  int get hashCode =>
      kind.hashCode ^ (duration ?? 0).hashCode ^ (value ?? 0).hashCode;

  @override
  String toString() {
    return '$kind: ${duration}ms, $value';
  }
}
