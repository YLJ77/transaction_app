import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
/*
  String titleInput;
  String amountInput;
*/
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1',
        title: 'meal',
        amount: 78.4,
        date: DateTime.now()
    ),
    Transaction(
        id: 't2',
        title: 'house',
        amount: 185.4,
        date: DateTime.now()
    ),
  ];
  void _addTransaction(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString()
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        ) ;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('app bar'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),),
          ],
        ),
        body:
        SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              child: Card(
                child: Text('CHART'),
                elevation: 5,
                color: Colors.blue,
              ),
              width: double.infinity,
            ),
            // UserTransaction()
            TransactionList(_userTransactions)
          ],)
          ,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(onPressed: () => _startAddNewTransaction(context), child: Icon(Icons.add),),
    );
  }
}
