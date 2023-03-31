import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {

  final String title;
  final VoidCallback handler;

  AdaptiveButton(this.title,this.handler);

  @override
  Widget build(BuildContext context) {
    print("build$handler");
    return Platform.isIOS
        ? CupertinoButton(
      child: Text(title,
      ),
      onPressed: handler,
      color: Colors.blue,
    )
        : TextButton(
        onPressed:  handler,
        child: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
