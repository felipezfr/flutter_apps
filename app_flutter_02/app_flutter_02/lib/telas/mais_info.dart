import 'package:flutter/material.dart';

class MaisInfoPage extends StatelessWidget {
  const MaisInfoPage({Key? key, required this.valor}) : super(key: key);
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Mais informações sobre o App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App de Aula',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$valor',
              style: Theme.of(context).textTheme.headline6,
            ),
            ElevatedButton(
              child: Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
