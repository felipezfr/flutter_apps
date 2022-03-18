import 'package:app_flutter_02/telas/contador.dart';
import 'package:app_flutter_02/telas/dias_vividos.dart';
import 'package:app_flutter_02/telas/home.dart';
import 'package:app_flutter_02/telas/sobre.dart';
import 'package:app_flutter_02/telas/usuario_list.dart';
import 'package:app_flutter_02/telas/projeto_list.dart';
import 'package:app_flutter_02/telas/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String titulo = 'App 02 Aula';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titulo,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/contador': (context) => const ContadorPage(title: 'Contador'),
        '/sobre': (context) => const SobrePage(),
        '/dias': (context) => const DiasVividosPage(),
        '/usuarios': (context) => const UsuarioListPage(),
        '/projetos': (context) => const ProjetoListPage(),
      },
    );
  }
}

