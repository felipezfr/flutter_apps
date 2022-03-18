import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Principal'), actions: <Widget>[
        TextButton(
          onPressed: () {},
          child: const Text('Action 1'),
        ),
      ]),
      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(image: AssetImage('images/upf50.png'), width: 150),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed('/contador');
                  //   },
                  //   child: Text('Abrir Contador'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed('/sobre');
                  //   },
                  //   child: Text('Abrir Sobre'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed('/dias');
                  //   },
                  //   child: Text('Dias vividos'),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/usuarios');
                    },
                    child: Text('Usuarios'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed('/atividades');
                  //   },
                  //   child: Text('Atividades'),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/projetos');
                    },
                    child: Text('Projetos'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text('Sair'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Center(
              child: Text(
                'Bem indo ao app Projeto Final',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 80, 5, 80),
              child: Text(
                'Para editar um Projeto ou atividade, aperte e segure',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),

      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Image(image: AssetImage('images/upf50.png')),
      //     Text(
      //       'Bem indo ao app de aula',
      //       style: Theme.of(context).textTheme.headline4,
      //     ),
      //     Text(
      //       'Aqui vamos montar alguns exemplos',
      //       style: Theme.of(context).textTheme.headline6,
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.of(context).pushNamed('/contador');
      //       },
      //       child: Text('Abrir Contador'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.of(context).pushNamed('/sobre');
      //       },
      //       child: Text('Abrir Sobre'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.of(context).pushNamed('/dias');
      //       },
      //       child: Text('Dias vividos'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.of(context).pushNamed('/usuarios');
      //       },
      //       child: Text('Usuarios'),
      //     ),

      //   ],
      // ),
    );
  }
}
