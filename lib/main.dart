import 'package:flutter/material.dart';
import 'package:money_dance/models/transaction.dart';
import 'package:money_dance/widgets/new_transaction.dart';
import 'package:money_dance/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
       home: MyHomePage(),
       theme: ThemeData(
         primarySwatch: Colors.pink,
         accentColor: Colors.amber,
         fontFamily: 'Quicksand',
         textTheme: ThemeData.light().textTheme.copyWith(
             title: TextStyle(fontFamily: 'OpenSans', fontSize: 18, fontWeight: FontWeight.bold)
         ),
         appBarTheme: AppBarTheme(
           textTheme: ThemeData.light().textTheme.copyWith(
             title: TextStyle(fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold)
           )
         )
       ),
       );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 78.45, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New Ball', amount: 789.45, date: DateTime.now())
  ];

  void _addNewTransaction({String title, double amount}) {
    final newTx = Transaction(
        title: title,
        date: DateTime.now(),
        id: DateTime.now().toString(),
        amount: amount);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(addTx: _addNewTransaction);
      // return GestureDetector(
      //   onTap: () {},
      //   child: NewTransaction(addTx: _addNewTransaction),
      //   behavior: HitTestBehavior.opaque,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
             onPressed: () => _startAddNewTransaction(context),
              )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Text('Chart'),
              elevation: 5,
            ),
            // UserTransactions()
            TransactionList(_transactions)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context)
      ),
    );
  }
}
