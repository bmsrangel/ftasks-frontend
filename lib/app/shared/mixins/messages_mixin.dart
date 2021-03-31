import 'package:flutter/material.dart';

abstract class MessagesMixin {
  final GlobalKey<ScaffoldMessengerState> scaffoldGlobalKey =
      GlobalKey<ScaffoldMessengerState>();

  void showError({
    @required String message,
    BuildContext context,
    GlobalKey<ScaffoldMessengerState> key,
  }) =>
      _showSnackbar(
          message: message, context: context, key: key, color: Colors.red);
  void showSuccess({
    @required String message,
    BuildContext context,
    GlobalKey<ScaffoldMessengerState> key,
  }) =>
      _showSnackbar(
          message: message,
          context: context,
          key: key,
          color: Theme.of(context).primaryColor);

  void _showSnackbar({
    String message,
    BuildContext context,
    GlobalKey<ScaffoldMessengerState> key,
    Color color,
  }) {
    final SnackBar snackbar =
        SnackBar(backgroundColor: color, content: Text(message));
    if (key != null) {
      key.currentState.showSnackBar(snackbar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
