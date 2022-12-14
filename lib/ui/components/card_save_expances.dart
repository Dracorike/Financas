import 'package:flutter/material.dart';

class CardSaveExpances extends StatefulWidget {
  const CardSaveExpances({super.key});
  
  @override
  State<StatefulWidget> createState() => _StateCardSaveExpances();  


}

class _StateCardSaveExpances extends State<CardSaveExpances>{
  final _titleExpance = TextEditingController();
  final _valueExpance = TextEditingController();

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
                        print('title: ${_titleExpance.text} \n value: ${_valueExpance.text}');
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
