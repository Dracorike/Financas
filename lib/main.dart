import 'dart:ffi';

import 'package:financas/model/transaction.dart';
import 'package:financas/ui/components/card_save_expances.dart';
import 'package:financas/ui/components/transaction_card.dart';
import 'package:flutter/material.dart';

main() => runApp(const ExpancesApp());

class ExpancesApp extends StatelessWidget {
  const ExpancesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final _listTransaction = [
    Transaction(id: 0, title: "Tênis novo", value: 80.00, date: DateTime.now()),
    Transaction(
        id: 1, title: "Lanche no Migs", value: 26.86, date: DateTime.now()),
    Transaction(id: 2, title: "Airfryer", value: 579.99, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App finanças')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text(
                'Graphs',
              ),
            )),
        Column(
          children: _listTransaction.map((tr) {
            return TransactionCard(transaction: tr);
          }).toList(),
        ),
        const CardSaveExpances()
      ]),
    );
  }
}
