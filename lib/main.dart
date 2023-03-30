
import 'package:flutter/cupertino.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      // theme: ThemeData(primarySwatch: Colors.purple,primaryColor: Colors.green),
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.brown,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
            color: Colors.white,
          ),
        ),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(error: Colors.red),
        errorColor: Colors.brown,
        // appBarTheme: AppBarTheme(
        //     textTheme: ThemeData.light().textTheme.copyWith(titleLarge: TextStyle(fontFamily: 'OpenSans',fontSize: 50), )
        // ),
        // accentColor: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String? titleInput;
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Dress', amount: 89.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New Spects', amount: 500.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransactions( String id, String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(id: id, title: title, amount: amount, date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _addBottomSheet(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addTransactions),
        behavior: HitTestBehavior.opaque,
      );

    },);
  }

  void _removeTransaction(String id) {

    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter App',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _addBottomSheet(context),
            icon: Icon(Icons.add),
            color: Colors.pinkAccent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             Chart(_recentTransactions),
             TransactionList(_userTransactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addBottomSheet(context),
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
    );
  }
}
// DateFormat('yyyy/MM/dd').format(transaction.date)
