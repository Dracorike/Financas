import 'package:financas/model/transaction.dart';
import 'package:financas/ui/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});
  final List<Transaction> recentTransactions;
  final int sevenDaysWeek = 7;

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(
      sevenDaysWeek,
      (index) {
        double totalSum = 0.0;
        final weekDay = DateTime.now().subtract(Duration(days: index));

        for (var transaction in recentTransactions) {
          var sameDay = transaction.date.day == weekDay.day;
          var sameMonth = transaction.date.month == weekDay.month;
          var sameYear = transaction.date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            totalSum += transaction.value;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay)[0],
          'value': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransaction.fold(0.0, (previousValue, element) {
      return previousValue + (element['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransaction.map(
              (objectTransaction) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: recentTransactions.isEmpty
                      ? ChartBar(
                          label: objectTransaction['day'] as String,
                          percentage: 0,
                          value: 0,
                        )
                      : ChartBar(
                          label: objectTransaction['day'] as String,
                          percentage: (objectTransaction['value'] as double) / _weekTotalValue,
                          value: objectTransaction['value'] as double,
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
