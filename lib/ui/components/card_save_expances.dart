import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardSaveExpances extends StatefulWidget {
  const CardSaveExpances({super.key, required this.saveNewExpance});
  final void Function(String, double, DateTime) saveNewExpance;

  @override
  State<CardSaveExpances> createState() => _CardSaveExpancesState();
}

class _CardSaveExpancesState extends State<CardSaveExpances> {
  final _titleExpance = TextEditingController();
  final _valueExpance = TextEditingController();
  DateTime _datePicked = DateTime.now();

  void _onSubmitForm() {
    final title = _titleExpance.text;
    final value = _parseToCurrency(_valueExpance.text);

    if (title.isEmpty || value <= 0) return;

    widget.saveNewExpance(title, value, _datePicked);
  }

  double _parseToCurrency(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0;
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then(
      (picked) {
        if (picked == null) return;

        setState(() {
          _datePicked = picked;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onSubmitted: ((value) => _onSubmitForm),
              decoration: const InputDecoration(labelText: 'Título'),
              controller: _titleExpance,
            ),
            TextField(
              controller: _valueExpance,
              onSubmitted: ((value) => _onSubmitForm()),
              decoration: const InputDecoration(labelText: 'valor: (R\$)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Data Selecionada: ${DateFormat('dd/MM/y').format(_datePicked)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Selecionar data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () => _onSubmitForm(),
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
