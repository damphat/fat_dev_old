import 'package:fat_dev/src/run_event.dart';
import 'package:fat_dev/src/run_widget.dart';
import 'package:flutter/material.dart';

@immutable
class RunPanel extends StatelessWidget {
  RunPanel({required this.events});

  final List<RunEvent> events;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    var first = true;
    for (var event in events) {
      if (first) {
        first = false;
      } else {
        // FIXME Divider sẽ lấy max width cho phép. Vậy khi Panel không có divider thì panel co lại
        children.add(const Divider(thickness: 1));
      }
      children.add(
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText2,
            children: [
              TextSpan(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: event.kind,
                      style: TextStyle(color: event.color),
                    ),
                    const TextSpan(text: ' ')
                  ]),
              if (event.duration != null)
                TextSpan(
                  text: '${event.duration}ms, ',
                  style: TextStyle(color: Colors.grey),
                ),
              if (event.value != null)
                TextSpan(
                  text: '${event.value}',
                ),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

void main() {
  runWidget(
    Container(
      color: Colors.black12,
      child: RunPanel(
        events: [
          RunEvent(kind: 'onData', value: 'hi', duration: 10),
          RunEvent(kind: 'onError', value: new Exception()),
          RunEvent(kind: 'onDone'),
        ],
      ),
    ),
  );
}
