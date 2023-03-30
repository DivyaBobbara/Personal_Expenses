import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions,this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return   transactions.isEmpty
            ? LayoutBuilder(builder: (ctx,constraints) {
          return Column(
            children: <Widget>[
              Text('No Transactions!! yet'),
              SizedBox(
                height: constraints.maxHeight*0.2,
              ),
              Container(
                  width: 100,
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/home.png',
                    fit: BoxFit.cover,
                  ))
            ],
          );
        })
            : ListView.builder(
                itemBuilder: (context, index) {
                  // return Card(
                  //   child: Row(
                  //     children: <Widget>[
                  //       Container(
                  //         margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  //         decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: Theme.of(context).primaryColor,
                  //               width: 5,
                  //             )),
                  //         padding: EdgeInsets.all(20),
                  //         child: Text('\$${transactions[index].amount.toStringAsFixed(2)}',
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 20,
                  //               color: Theme.of(context).primaryColor,
                  //             )),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text(
                  //             transactions[index].title,
                  //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  //           ),
                  //           Text(
                  //             DateFormat.yMMMd().format(transactions[index].date),
                  //             style: TextStyle(color: Colors.blueGrey),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing:IconButton(icon: Icon(Icons.delete),
                        onPressed: () => deleteTransaction(transactions[index].id),
                        color: Theme.of(context).errorColor,),
                    ),
                  );
                },
                itemCount: transactions.length,
    );
  }
}
