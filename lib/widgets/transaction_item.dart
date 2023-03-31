import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionItem(this.transaction, this.deleteTransaction);


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Text('\$${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width> 400 ?
        TextButton.icon(onPressed: () => deleteTransaction(transaction.id) ,
            icon: Icon(Icons.delete),
            label: Text('delete')):
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => deleteTransaction(transaction.id),
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
