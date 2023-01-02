import 'dart:math';

import 'package:financas/ui/components/card_save_expances.dart';
import 'package:financas/ui/components/chart.dart';
import 'package:financas/ui/components/list_transaction.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';

main() => runApp(ExpancesApp());

class ExpancesApp extends StatelessWidget {
  ExpancesApp({super.key});
  final ThemeData layoutTheme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: layoutTheme.copyWith(
        colorScheme: layoutTheme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: layoutTheme.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'Arial',
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        appBarTheme: layoutTheme.appBarTheme.copyWith(
          titleTextStyle: const TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _listTransaction = [];
  final List<Transaction> _recentsTransactions = [];
  static const int maxNumberUid = 999999;

  void _createNewExpance(String title, double value, DateTime transactionDate) {
    var newExpance = Transaction(
      id: Random().nextInt(maxNumberUid),
      title: title,
      value: value,
      date: transactionDate,
    );

    setState(() {
      _listTransaction.add(newExpance);
      _recentsTransactions.clear();
      _recentsTransactions.addAll(_recentTransactionList);
    });

    Navigator.of(context).pop();
  }

  _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return CardSaveExpances(
            saveNewExpance: ((title, value, transactionDate) =>
                _createNewExpance(title, value, transactionDate)),
          );
        });
  }

  _deleteExpance(int id) {
    setState(() {
      _listTransaction.removeWhere((element) => element.id == id);
      _recentsTransactions.clear();
      _recentsTransactions.addAll(_recentTransactionList);
    });
  }

  List<Transaction> get _recentTransactionList {
    return _listTransaction.where((objectTransaction) {
      return objectTransaction.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final AppBar mainScreenAppBar = AppBar(
      title: const Text('App finanças'),
      actions: [
        IconButton(
            onPressed: () => _openTransactionForm(context),
            icon: const Icon(Icons.add))
      ],
    );
    final availableSizeScreen = MediaQuery.of(context).size.height -
        mainScreenAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: mainScreenAppBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: SizedBox(
                height: availableSizeScreen * 0.3,
                child: Chart(recentTransactions: _recentsTransactions),
              ),
            ),
            _listTransaction.isNotEmpty
                ? SizedBox(
                    height: availableSizeScreen * 0.7,
                    child: ListTransaction(
                      listTransaction: _listTransaction,
                      deleteExpance: _deleteExpance,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text('nothing here'),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionForm(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

List<Transaction> get mockTransactions {
  return [
    Transaction(
      id: Random().nextInt(9999),
      title: 'Item 0',
      value: 99.99,
      date: DateTime.now().subtract(
        const Duration(days: 4),
      ),
    ),
    Transaction(
      id: Random().nextInt(9991),
      title: 'Item 1',
      value: 100.00,
      date: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Transaction(
      id: Random().nextInt(9992),
      title: 'Item 2',
      value: 400.00,
      date: DateTime.now().subtract(
        const Duration(days: 33),
      ),
    )
  ];
}
