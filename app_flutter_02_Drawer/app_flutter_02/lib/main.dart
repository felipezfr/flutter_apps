import 'package:app_flutter_02/telas/home.dart';
import 'package:app_flutter_02/telas/login.dart';
import 'package:app_flutter_02/telas/projeto_list.dart';
import 'package:app_flutter_02/telas/usuario_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String titulo = 'Trabalho Final';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titulo,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // home: const LoginPage(),
      initialRoute: '/login',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/usuarios': (context) => const UsuarioListPage(),
        '/projetos': (context) => const ProjetoListPage(),
      },
    );
  }
}
