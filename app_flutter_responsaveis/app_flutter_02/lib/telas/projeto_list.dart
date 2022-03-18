import 'package:app_flutter_02/api/projeto_api.dart';
import 'package:app_flutter_02/dominio/projeto.dart';
import 'package:app_flutter_02/telas/projeto_edit.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class ProjetoListPage extends StatefulWidget {
  const ProjetoListPage({Key? key}) : super(key: key); 

  @override
  ProjetoListPageState createState() {
    return ProjetoListPageState();
  }
}

class ProjetoListPageState extends State<ProjetoListPage> {
  List<Projeto> lista = [];

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  void _atualizarLista() {
    lista.clear();
    ProjetoApi.getList().then((value) => {
          setState(() {
            lista.addAll(value);
          })
        });
  }

  void _inserir() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ProjetoEditPage(obj: Projeto()),
      ),
    );
    _atualizarLista();
  }

  void _editar(Projeto selecao) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ProjetoEditPage(obj: selecao),
      ),
    );
    _atualizarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projetos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
            padding: const EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            children: lista
                .map((data) => ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(data.titulo.toString()),
                      onTap: () => _editar(data),
                    ))
                .toList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inserir,
        tooltip: 'Inserir',
        child: const Icon(Icons.add),
        heroTag: 'Botão inserir',
      ),
    );
  }
}
