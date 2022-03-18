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
      appBar: AppBar(
        title: Text('Principal'),
        actions: <Widget>[
          TextButton(
            onPressed: () { 
            },
            child: const Text('Action 1'),
          ),
        ]
      ),

      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(image: AssetImage('images/upf50.png'), height: 150,),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/contador');
              }, 
              child: Text('Abrir Contador'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/sobre');
              }, 
              child: Text('Abrir Sobre'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/dias');
              }, 
              child: Text('Dias vividos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/usuarios');
              }, 
              child: Text('Usuarios'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/projetos');
              }, 
              child: Text('Projetos'),
            )

          ],
        ),
      ),




      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('images/upf50.png')),
            Text(
              'Bem indo ao app de aula',
               style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Aqui vamos montar alguns exemplos',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
