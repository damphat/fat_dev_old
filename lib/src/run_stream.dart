import 'dart:async';

import 'package:fat_dev/src/run_event.dart';

Stream<RunEvent> runFuture(Future future) async* {
  try {
    var value = await future;
    yield RunEvent(kind: 'resolve', value: value);
  } catch (err) {
    yield RunEvent(kind: 'reject', value: err);
  }
}

Stream<RunEvent> runStream(Stream stream) {
  var controller = StreamController<RunEvent>();
  stream.listen((event) {
    controller.add(RunEvent(kind: 'onData', value: event));
  }, onError: (err) {
    controller.add(RunEvent(kind: 'onError', value: err));
  }, onDone: () {
    controller.add(RunEvent(kind: 'onDone'));
    controller.close();
  });
  return controller.stream;
}

Stream<RunEvent> runFunction(Function? func) async* {
  if (func == null) {
    yield RunEvent(kind: 'throw', value: 'func is null');
    return;
  }

  try {
    var ret = func();
    yield RunEvent(kind: 'return', value: ret);

    if (ret is Future) {
      yield* runFuture(ret);
    } else if (ret is Stream) {
      yield* runStream(ret);
    } else {
      // yield RunEvent(kind: 'return', value: ret);
    }
  } catch (err) {
    yield RunEvent(kind: 'throw', value: err);
  }
}
