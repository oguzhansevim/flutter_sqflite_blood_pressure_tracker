import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoAlert extends StatelessWidget {
  final List<Widget> actions;
  final String title;

  const CupertinoAlert({Key key, this.actions, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      actions: actions,
    );
  }
}
