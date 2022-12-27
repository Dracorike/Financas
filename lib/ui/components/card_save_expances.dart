import 'package:flutter/material.dart';

class CardSaveExpances extends StatefulWidget {
  const CardSaveExpances({super.key, required this.saveNewExpance});
  final void Function(String, double) saveNewExpance;

  @override
  State<CardSaveExpances> createState() => _CardSaveExpancesState();
}

class _CardSaveExpancesState extends State<CardSaveExpances> {
  final _titleExpance = TextEditingController();
  final _valueExpance = TextEditingController();

  void _onSubmitForm() {
    final title = _titleExpance.text;
    final value = _parseToCurrency(_valueExpance.text);

    if (title.isEmpty || value <= 0) return;

    widget.saveNewExpance(title, value);
  }

  double _parseToCurrency(String value){
    return double.tryParse(value.replaceAll(',', '.')) ?? 0;
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
              onSubmitted: ((value) =>  _onSubmitForm),
              decoration: const InputDecoration(labelText: 'Título'),
              controller: _titleExpance,
            ),
            TextField(
              controller: _valueExpance,
              onSubmitted: ((value) => _onSubmitForm()),
              decoration: const InputDecoration(labelText: 'valor: (R\$)'),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _onSubmitForm(),
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(color: Colors.purple),
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
