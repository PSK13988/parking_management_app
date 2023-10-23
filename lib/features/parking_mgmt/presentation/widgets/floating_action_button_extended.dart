import 'package:flutter/material.dart';

class FloatingActionButtonExtended extends StatelessWidget {
  const FloatingActionButtonExtended({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
  });

  final String title;
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        onPressed: () => onPressed.call(),
        label: Text(title),
        icon: Icon(icon),
      );
}
