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
  final String appBarTitle = 'App finanças';

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
      },
    );
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
      title: Text(appBarTitle),
      actions: [
        IconButton(
          onPressed: () => _openTransactionForm(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
    final availableSizeScreen = MediaQuery.of(context).size.height -
        mainScreenAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final double chartSize = availableSizeScreen * 0.3;
    final double listTransactionSize =
        availableSizeScreen * 0.7;

    return Scaffold(
      appBar: mainScreenAppBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: SizedBox(
                height: chartSize,
                child: Chart(
                  recentTransactions: _recentsTransactions,
                ),
              ),
            ),
            SizedBox(
              height: listTransactionSize,
              child: ListTransaction(
                listTransaction: _listTransaction,
                deleteExpance: _deleteExpance,
              ),
            )
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
