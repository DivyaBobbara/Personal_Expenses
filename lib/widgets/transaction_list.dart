import 'package:expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    print("build() transaction_list");
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('No Transactions!! yet',style: Theme.of(context).textTheme.headlineMedium,),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  FittedBox(
                    child: Container(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'assets/images/home.png',
                          fit: BoxFit.cover,
                        )),
                  )
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
              return TransactionItem(transactions[index], deleteTransaction);
            },
            itemCount: transactions.length,
          );
  }
}
