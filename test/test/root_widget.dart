import 'package:flutter/material.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({
    super.key,
    required this.widget,
  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking app',
      home: widget,
    );
  }
}
