import 'package:flutter/material.dart';

void runWidget(Widget widget) {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('${widget.runtimeType}')),
        body: widget,
      ),
    ),
  );
}
