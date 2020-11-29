import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_dance/models/transaction.dart';
import 'package:money_dance/widgets/chart.dart';
import 'package:money_dance/widgets/new_transaction.dart';
import 'package:money_dance/widgets/transaction_list.dart';

void main() {
  // 不允许横屏
/*   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final curScaleFactor = mediaQuery.textScaleFactor;
    return MaterialApp(
      title: 'App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          //  errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 78.45, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New Ball', amount: 789.45, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction({String title, double amount, DateTime date}) {
    final newTx = Transaction(
        title: title,
        date: date,
        id: DateTime.now().toString(),
        amount: amount);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTx: _addNewTransaction);
          // return GestureDetector(
          //   onTap: () {},
          //   child: NewTransaction(addTx: _addNewTransaction),
          //   behavior: HitTestBehavior.opaque,
          // );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_transactions, _deleteTransaction));
    Widget getChart() {
      final double factor = isLandscape ? 0.7 : 0.3;
      return Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              factor,
          child: Chart(_recentTransactions));
    }

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart', style: Theme.of(context).textTheme.title),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showChart,
                      onChanged: (val) => setState(() {
                            _showChart = val;
                          }))
                ],
              ),
            if (!isLandscape) ...[getChart(), txListWidget],
            if (isLandscape) _showChart ? getChart() : txListWidget
          ],
        ),
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody, navigationBar: appBar)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context)),
          );
  }
}
