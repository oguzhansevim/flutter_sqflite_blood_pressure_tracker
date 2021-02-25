import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoAction extends StatelessWidget {
  final String text;
  final void function;

  const CupertinoAction({Key key, this.text, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      child: Text(text),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
