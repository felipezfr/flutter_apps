import 'package:app_flutter_02/telas/mais_info.dart';
import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sobre o App'),
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
              'Informações úteis sobre o app ...',
              style: Theme.of(context).textTheme.headline6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Mais informações'),
                  onPressed: () {
                    Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (context) => MaisInfoPage(
                           valor: 'Passando mais informações...'
                          ),
                        ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Voltar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),




            
          ],
        ),
      ),
    );
  }
}
