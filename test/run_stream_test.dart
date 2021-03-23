import 'dart:async';

import 'package:fat_dev/src/run_event.dart';
import 'package:fat_dev/src/run_stream.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('null', () {
    var s = runFunction(null);

    expect(s, emitsInOrder([RunEvent(kind: 'throw', value: 'func is null')]));
  });
  test('int foo()', () {
    var s = runFunction(() => 5);

    expect(
        s,
        emitsInOrder([
          RunEvent(kind: 'return', value: 5),
        ]));
  });

  test('Future foo() - resolve', () {
    var s = runFunction(() => Future.value(555));

    expect(
        s,
        emitsInOrder([
          isA<RunEvent>(),
          RunEvent(kind: 'resolve', value: 555),
        ]));
  });

  test('reject', () async {
    (f) async* {
      try {
        await f;
      } catch (e) {
        print(e);
      }
    }(Future.error('error'));
  });

  test('Future foo() - reject', () async {
    var s = runFunction(() async {
      await Future.delayed(Duration(seconds: 0));
      throw 'eee';
    });

    expect(
        s,
        emitsInOrder([
          isA<RunEvent>(),
          RunEvent(kind: 'reject', value: 'eee'),
        ]));
  });

  test('Stream foo()', () {
    var s = runFunction(() {
      var controller = StreamController();
      controller.add(1);
      controller.addError('eee');
      controller.addError('eee');
      controller.add(2);
      controller.close();

      return controller.stream;
    });

    expect(
        s,
        emitsInOrder([
          isA<RunEvent>(),
          RunEvent(kind: 'onData', value: 1),
          RunEvent(kind: 'onError', value: 'eee'),
          RunEvent(kind: 'onError', value: 'eee'),
          RunEvent(kind: 'onData', value: 2),
          RunEvent(kind: 'onDone'),
        ]));
  });
}
