import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    int quesIdx = 0;

    List<String> questions = <String>[
      "What's your favorite color?",
      "What's your favorite animarl?"
    ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Foo'),
      ),
      body: Column(
        children: <Widget>[
          Text(questions[this.quesIdx]),
          RaisedButton(child: Text('Answer 1'), onPressed: answerQuestion),
          RaisedButton(child: Text('Answer 2'), onPressed: null),
          RaisedButton(child: Text('Answer 3'), onPressed: null),
        ],
      ),
    ));
  }

  void answerQuestion() {
    setState(() {
    this.quesIdx = this.quesIdx == this.questions.length - 1 ? 0 : ++this.quesIdx;
    });
    print(this.quesIdx);
  }
}
