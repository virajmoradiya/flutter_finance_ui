import 'package:flutter/material.dart';

class AppWidgets {
  static AppBar commonAppBar({required String title, required BuildContext context, required List<Widget> actions}) {
    return AppBar(
        title: Text(title, style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: actions);
  }
}
