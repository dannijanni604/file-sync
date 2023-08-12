import 'package:flutter/material.dart';

void appSnackBar(BuildContext context, String message) {
  var snakBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snakBar);
}
