import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    int quesIdx = 0;
  final questions = const [
      {
        'question': "What's your favorite colors?",
        'answers': ['red','blue','yellow']
      },
      {
        'question': "What's your favorite animarl?",
        'answers': ['dog','cat','pig']
      },
    ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Foo'),
      ),
      body: Column(
        children: [
          Question(text: questions[this.quesIdx]['question']),
          ...(questions[this.quesIdx]['answers'] as List<String>)
          .map((answer) => Answer(text: answer, handler: answerQuestion)).toList(),
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
