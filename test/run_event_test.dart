import 'package:fat_dev/src/run_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('color can be red, green, null', () {
    expect(RunEvent().color, null);
    expect(RunEvent(kind: ' xxx ').color, null);

    expect(RunEvent(kind: ' ERR ').color, Colors.red);
    expect(RunEvent(kind: ' reject ').color, Colors.red);
    expect(RunEvent(kind: ' throw ').color, Colors.red);

    expect(RunEvent(kind: ' DATA ').color, Colors.green);
    expect(RunEvent(kind: ' resolve ').color, Colors.green);
  });
}
