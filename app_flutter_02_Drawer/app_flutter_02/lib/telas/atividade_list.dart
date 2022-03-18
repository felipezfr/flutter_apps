import 'package:app_flutter_02/api/atividade_api.dart';
import 'package:app_flutter_02/dominio/atividade.dart';
import 'package:app_flutter_02/dominio/login.dart';
import 'package:app_flutter_02/dominio/projeto.dart';
import 'package:app_flutter_02/telas/atividade_edit.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class AtividadeListPage extends StatefulWidget {
  final Projeto projeto;

  const AtividadeListPage({Key? key, required this.projeto}) : super(key: key);

  @override
  AtividadeListPageState createState() {
    return AtividadeListPageState();
  }
}

class AtividadeListPageState extends State<AtividadeListPage> {
  List<Atividade> listaAtividades = [];

  Projeto? projeto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projeto = widget.projeto;
    _atualizarLista();
  }

  void _atualizarLista() {
    listaAtividades.clear();
    AtividadeApi.getListById(projeto!.id!).then((value) => {
          setState(() {
            print(value);
            listaAtividades.addAll(value);
          })
        });
  }

  void _inserir() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AtividadeEditPage(obj: Atividade()),
      ),
    );
    _atualizarLista();
  }

  void _editar(Atividade selecao) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AtividadeEditPage(obj: selecao),
      ),
    );
    _atualizarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades: ' + projeto!.titulo!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
            padding: const EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            children: listaAtividades
                .map((data) => ListTile(
                      leading: const Icon(Icons.article),
                      title: Text(data.titulo.toString()),
                      subtitle: Text(data.responsavel!.nome.toString()),
                      onLongPress: () => _editar(data),
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
