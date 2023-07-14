import 'package:flutter/material.dart';

void showSnackbar(
    {required BuildContext context,
    required String content,
    required Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: color,
  ));
}
