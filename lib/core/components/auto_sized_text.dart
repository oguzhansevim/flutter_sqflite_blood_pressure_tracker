import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizedText extends StatelessWidget {
  final String text;

  const AutoSizedText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text);
  }
}
