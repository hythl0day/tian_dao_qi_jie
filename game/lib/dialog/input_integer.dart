import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samsara/ui/responsive_window.dart';
import 'package:samsara/ui/integer_input_field.dart';
import 'package:samsara/ui/close_button.dart';

import '../config.dart';

class InputIntegerDialog extends StatefulWidget {
  static Future<int?> show({
    required BuildContext context,
    required int min,
    required int max,
    String? title,
  }) {
    return showDialog<int?>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) {
        return InputIntegerDialog(
          min: min,
          max: max,
          title: title,
        );
      },
    );
  }

  const InputIntegerDialog({
    super.key,
    required this.min,
    required this.max,
    this.title,
  });

  final int min;
  final int max;
  final String? title;

  @override
  State<InputIntegerDialog> createState() => _InputIntegerDialogState();
}

class _InputIntegerDialogState extends State<InputIntegerDialog> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWindow(
      alignment: AlignmentDirectional.center,
      child: SizedBox(
        width: 140,
        height: 140,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.title ?? engine.locale('inputInteger')),
            actions: const [CloseButton2()],
          ),
          body: Container(
            alignment: AlignmentDirectional.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: IntegerInputField(
                    min: widget.min,
                    max: widget.max,
                    controller: _textEditingController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(
                        int.tryParse(_textEditingController.text),
                      );
                    },
                    child: Text(
                      engine.locale('confirm'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}