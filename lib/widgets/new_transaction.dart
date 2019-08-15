import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}
class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountCOntroller = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountCOntroller.text);
    if (enteredTitle.isEmpty || enteredAmount.isNaN || enteredAmount < 0) return;
    widget.addTx(
        titleController.text,
        double.parse(amountCOntroller.text)
    );
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        child:
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
/*
                onChanged: (val) {
                  titleInput = val;
                },
*/
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountCOntroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
//                onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text('No Date Chosen'),
                    FlatButton(
                      onPressed: (){},
                      child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: submitData,
                child: Text('Add Transaction', ),
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        )

    );
  }
}
