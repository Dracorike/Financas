import 'package:financas/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatelessWidget {
  const ListTransaction({super.key, required this.listTransaction});
  final List<Transaction> listTransaction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: listTransaction.length,
        itemBuilder: (context, index) {
          final transaction = listTransaction[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('R\$ ${transaction.value.toStringAsFixed(2)}'),
                  ),
                ),
              ),
              title: Text(transaction.title),
              subtitle: Text(
                DateFormat("dd MM yyyy").format(transaction.date),
              ),
            ),
          );
        },
      ),
    );
  }
}
