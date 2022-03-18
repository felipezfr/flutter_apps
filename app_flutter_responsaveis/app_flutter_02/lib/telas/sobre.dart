import 'package:app_flutter_02/telas/mais_info.dart';
import 'package:app_flutter_02/util/dialogos.dart';
import 'package:flutter/material.dart';

/*
void _alerta() {
    Dialogos.showAlertDialog(context, 'Este é um alerta');
  }

  void _confirmar() {
    Dialogos.showConfirmDialog(context, 'Executar a operação?',
        () => (Dialogos.showAlertDialog(context, 'Confirmou! Fazer algo...')));
  }
*/

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
                        builder: (context) =>
                            MaisInfoPage(valor: 'Passando mais informações...'),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Voltar'),
                  onPressed: () {
                    Dialogos.showConfirmDialog( context, 'Você deseja mesmo voltar?',  () => {
                      Dialogos.showAlertDialog(context, 'Volte sempre :)', () => {
                         Navigator.of(context).pop()
                      }),
                    }  
                  );
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
