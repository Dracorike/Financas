import 'dart:math';

import 'package:financas/ui/components/transaction_card.dart';
import 'package:flutter/material.dart';

import '../../model/transaction.dart';
import 'card_save_expances.dart';

class ExpanseUserInterface extends StatefulWidget {
  const ExpanseUserInterface({super.key});

  @override
  State<StatefulWidget> createState() => _ExpanseUserInterfaceState();
}

class _ExpanseUserInterfaceState extends State<ExpanseUserInterface> {
  static const int maxNumberUid = 999999;
  final _listTransaction = [
    Transaction(id: 0, title: "Tênis novo", value: 80.00, date: DateTime.now()),
    Transaction(
        id: 1, title: "Lanche no Migs", value: 26.86, date: DateTime.now()),
    Transaction(id: 2, title: "Airfryer", value: 579.99, date: DateTime.now())
  ];

  void _createNewExpance(String title, double value) {
    var newExpance = Transaction(
        id: Random().nextInt(maxNumberUid),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _listTransaction.add(newExpance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._listTransaction.map((tr) {
          return TransactionCard(transaction: tr);
        }).toList(),
        CardSaveExpances(saveNewExpance: _createNewExpance,)
      ],
    );
  }
}
