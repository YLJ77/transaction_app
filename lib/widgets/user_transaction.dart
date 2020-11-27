import 'package:flutter/material.dart';
import 'package:money_dance/models/transaction.dart';
import 'package:money_dance/widgets/new_transaction.dart';
import 'package:money_dance/widgets/transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addTx: _addNewTransaction),
         TransactionList(_transactions)],
    );
  }
}
