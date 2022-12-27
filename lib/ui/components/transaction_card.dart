import 'package:financas/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});
  final Transaction transaction;
  final double sizeBox = 50;

  String formatDateString(String date) {
    if (date.isEmpty) return '10/10/2010';
    var splitedString = date.substring(0, 10).split('-').reversed;
    var formatDateString = splitedString
        .toString()
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(', ', '/');

    return formatDateString;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)),
            padding: const EdgeInsets.all(10),
            child: Text(
              'R\$ ${transaction.value.toStringAsFixed(2).replaceAll('.', ',')} ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transaction.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                formatDateString(transaction.date.toString()),
                style: const TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
