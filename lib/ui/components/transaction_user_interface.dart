import 'package:financas/ui/components/transaction_card.dart';
import 'package:flutter/material.dart';

import '../../model/transaction.dart';
import 'card_save_expances.dart';

class TransactionUserInterface extends StatelessWidget {
  TransactionUserInterface({super.key});
  final _listTransaction = [
    Transaction(id: 0, title: "Tênis novo", value: 80.00, date: DateTime.now()),
    Transaction(
        id: 1, title: "Lanche no Migs", value: 26.86, date: DateTime.now()),
    Transaction(id: 2, title: "Airfryer", value: 579.99, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._listTransaction.map((tr) {
          return TransactionCard(transaction: tr);
        }).toList(),
        const CardSaveExpances()
      ],
    );
  }
}
