import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String text;
  final Function handler;
  Answer({this.text, this.handler});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(this.text),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: this.handler
        ),
    );
  }
}