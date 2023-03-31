import 'package:flutter/cupertino.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp
  // ]);
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
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'Quicksand',
            color: Colors.brown,
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  // String? titleInput;
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Dress', amount: 89.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New Spects', amount: 500.99, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'New Dress', amount: 89.99, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'New Spects', amount: 500.99, date: DateTime.now()),
    Transaction(
        id: 't5', title: 'New Dress', amount: 89.99, date: DateTime.now()),
    Transaction(
        id: 't6', title: 'New Spects', amount: 500.99, date: DateTime.now()),
    Transaction(
        id: 't5', title: 'New Dress', amount: 89.99, date: DateTime.now()),
    Transaction(
        id: 't6', title: 'New Spects', amount: 500.99, date: DateTime.now()),
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

  bool _showChart = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("newState $state");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  void _addTransactions(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _addBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransactions),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, dynamic appBar, Widget txListWidget) {
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Chart',style: Theme.of(context).textTheme.headlineMedium,),
        Switch.adaptive(
            activeColor: Theme.of(context).primaryColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            }),
      ],
    ), _showChart
        ? Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.6,
        child: Chart(_recentTransactions))
        : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, dynamic appBar, Widget txListWidget ) {
    return [Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.4,
        child: Chart(_recentTransactions)),txListWidget];
  }

  @override
  Widget build(BuildContext context) {
    print("build() MyHomePAge");
    final mediaQuery = MediaQuery.of(context);
    final isLandscapeOrientation =
        mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS ?
    CupertinoNavigationBar(
      middle: Text("Personal Expenses"),
      trailing:Row(
        mainAxisSize: MainAxisSize.min ,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _addBottomSheet(context) ,
          ),
        ],
      ) ,
    )
        :AppBar(
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
    ) as PreferredSizeWidget;
    final txListWidget = Container(
        height:
            (mediaQuery.size.height - appBar.preferredSize.height) *
                0.6,
        child: TransactionList(_userTransactions, _removeTransaction));
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (isLandscapeOrientation) ..._buildLandscapeContent(mediaQuery,appBar,txListWidget),
            // appBar = Platform.isIOS ? appBar = appBar as ObstructingPreferredSizeWidget : appBar =  appBar as PreferredSizeWidget;
            if (!isLandscapeOrientation) ..._buildPortraitContent(mediaQuery,appBar,txListWidget),
            // if (!isLandscapeOrientation) txListWidget,
            // if (isLandscapeOrientation)

          ],
        ),
      ),
    );
    return Platform.isIOS ? CupertinoPageScaffold(child: pageBody, navigationBar: appBar as ObstructingPreferredSizeWidget ,) :Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addBottomSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
// DateFormat('yyyy/MM/dd').format(transaction.date)
