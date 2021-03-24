import 'package:fat_dev/src/run_event.dart';
import 'package:flutter/material.dart';

@immutable
class RunPanel extends StatelessWidget {
  RunPanel({required this.events});

  final List<RunEvent> events;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var event in events) {
      children.add(RichText(text: TextSpan(text: '$event')));
    }
    return Column(
      children: children,
    );
  }
}
