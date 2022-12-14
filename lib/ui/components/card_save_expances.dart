import 'package:flutter/material.dart';

class CardSaveExpances extends StatefulWidget {
  const CardSaveExpances({super.key});
  
  @override
  State<StatefulWidget> createState() => _StateCardSaveExpances();  


}

class _StateCardSaveExpances extends State<CardSaveExpances>{
  String _titleExpance = '';
  double _valueExpance = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Título'),
                  onChanged: (newValue) => _titleExpance = newValue,
                ),
                TextField(
                  onChanged: (newValue) => _valueExpance = double.parse(newValue),
                  decoration: const InputDecoration(labelText: 'valor: (R\$)'),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
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
