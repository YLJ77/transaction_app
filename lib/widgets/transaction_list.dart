import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_dance/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 20),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, idx) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              transactions[idx].amount.toStringAsFixed(2),
                            ),
                          ),
                        ),
                      ),
                      title: Text(transactions[idx].title,
                          style: Theme.of(context).textTheme.title),
                      subtitle: Text(DateFormat('yyyy-MM-dd').format(transactions[idx].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[idx].id)),
                      ),
                );
/*                 return Card(
                    child: Row(children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            transactions[idx].amount.toStringAsFixed(2),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          )),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(transactions[idx].title,
                                // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                style: Theme.of(context).textTheme.title),
                            Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(transactions[idx].date),
                                style: TextStyle(color: Colors.grey))
                          ])
                  ])); */
              },
              itemCount: transactions.length,
            ),
    );
  }
}
