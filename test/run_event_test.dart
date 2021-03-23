import 'package:fat_dev/src/run_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('color can be red, green, null', () {
    expect(RunEvent().color, Colors.black);
    expect(RunEvent(kind: ' xxx ').color, Colors.black);

    expect(RunEvent(kind: ' ERR ').color, Colors.red);
    expect(RunEvent(kind: ' reject ').color, Colors.red);
    expect(RunEvent(kind: ' throw ').color, Colors.red);

    expect(RunEvent(kind: ' DATA ').color, Colors.green);
    expect(RunEvent(kind: ' resolve ').color, Colors.green);
  });

  test('equals', () {
    expect(RunEvent(), RunEvent());
    expect(RunEvent(kind: 'x'), RunEvent(kind: 'x'));
    expect(RunEvent(value: 'x'), RunEvent(value: 'x'));
    expect(RunEvent(duration: 1), RunEvent(duration: 1));
  });

  test('not equals', () {
    expect(RunEvent(), RunEvent());
    expect(RunEvent(kind: 'x'), isNot(RunEvent(kind: 'y')));
    expect(RunEvent(value: 'x'), isNot(RunEvent(value: 'y')));
    expect(RunEvent(duration: 0), isNot(RunEvent(value: '1')));
  });
}
