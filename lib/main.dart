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
          )),
          appBarTheme: layoutTheme.appBarTheme.copyWith(
              titleTextStyle: const TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _listTransaction = mockTransactions;
  static const int maxNumberUid = 999999;

  void _createNewExpance(String title, double value) {
    var newExpance = Transaction(
      id: Random().nextInt(maxNumberUid),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _listTransaction.add(newExpance);
    });

    Navigator.of(context).pop();
  }

  void _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return CardSaveExpances(
            saveNewExpance: ((title, value) => _createNewExpance(title, value)),
          );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('App finanças'),
        actions: [
          IconButton(
              onPressed: () => _openTransactionForm(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransactions: _recentTransactionList),
            _listTransaction.isNotEmpty
                ? ListTransaction(listTransaction: _listTransaction)
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
