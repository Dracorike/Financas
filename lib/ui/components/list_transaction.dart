import 'package:financas/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatelessWidget {
  const ListTransaction({
    super.key,
    required this.listTransaction,
    required this.deleteExpance,
  });
  final List<Transaction> listTransaction;
  final Function(int) deleteExpance;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: listTransaction.isNotEmpty
          ? ListView.builder(
              itemCount: listTransaction.length,
              itemBuilder: (context, index) {
                final transaction = listTransaction[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              'R\$ ${transaction.value.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(transaction.title),
                    subtitle: Text(
                      DateFormat("dd MM yyyy").format(transaction.date),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteExpance(transaction.id),
                    ),
                  ),
                );
              },
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
    );
  }
}
