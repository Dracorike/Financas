import 'package:financas/model/transaction.dart';
import 'package:financas/ui/components/transaction_card.dart';
import 'package:flutter/material.dart';

class ListTransaction extends StatelessWidget {
  const ListTransaction({super.key, required this.listTransaction});
  final List<Transaction> listTransaction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: listTransaction.length,
        itemBuilder: (context, index) {
          final transaction = listTransaction[index];
          return TransactionCard(transaction: transaction);
        },
      ),
    );
  }
}
