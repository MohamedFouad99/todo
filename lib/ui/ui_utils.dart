// ignore_for_file: prefer_const_constructors, avoid_init_to_null, unused_local_variable

import 'package:flutter/material.dart';

void showLoading(BuildContext context, String message,
    {bool isCancelable = false}) {
  showDialog(
      barrierDismissible: isCancelable,
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              ),
            ],
          ),
        );
      });
}

void hideDialoge(BuildContext context) {
  Navigator.pop(context);
}

void showMessage(BuildContext context, String message, String postiveActionText,
    VoidCallback postiveAction,
    {String? negativeActionText = null,
    VoidCallback? negativeAction = null,
    bool isCanclelable = true}) {
  List<Widget> actions = [
    TextButton(onPressed: postiveAction, child: Text(postiveActionText)),
  ];
  if (negativeActionText != null) {
    actions.add(
        TextButton(onPressed: negativeAction, child: Text(negativeActionText)));
  }

  showDialog(
      barrierDismissible: isCanclelable,
      context: context,
      builder: (buildContext) {
        return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ),
            actions: actions);
      });
}
