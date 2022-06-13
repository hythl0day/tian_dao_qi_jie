import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(text),
        ),
      ),
    );
  }
}
