import 'package:financas/ui/components/transaction_user_interface.dart';
import 'package:flutter/material.dart';

main() => runApp(const ExpancesApp());

class ExpancesApp extends StatelessWidget {
  const ExpancesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App finanças')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const [
        SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text(
                'Graphs',
              ),
            )),
        ExpanseUserInterface()
      ]),
    );
  }
}
