import 'package:flutter/material.dart';

class CardSaveExpances extends StatelessWidget {
  CardSaveExpances({super.key, required this.saveNewExpance});
  final _titleExpance = TextEditingController();
  final _valueExpance = TextEditingController();
  final void Function(String, double) saveNewExpance;
  
  @override
  Widget build(BuildContext context){
    return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Título'),
                  controller: _titleExpance,
                ),
                TextField(
                  controller: _valueExpance,
                  decoration: const InputDecoration(labelText: 'valor: (R\$)'),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        final title = _titleExpance.text;
                        final value = double.tryParse(_valueExpance.text) ?? 0;
                        saveNewExpance(title, value);
                      },
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
