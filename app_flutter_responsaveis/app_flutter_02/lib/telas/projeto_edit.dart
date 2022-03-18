import 'package:app_flutter_02/api/projeto_api.dart';
import 'package:app_flutter_02/api/usuario_api.dart';
import 'package:app_flutter_02/dominio/projeto.dart';
import 'package:app_flutter_02/dominio/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:getwidget/getwidget.dart';

// Define a custom Form widget.
class ProjetoEditPage extends StatefulWidget {
  const ProjetoEditPage({Key? key, required this.obj}) : super(key: key);
  // Este será o objeto que estará sendo editado. Novo ou um existente
  final Projeto obj;

  @override
  ProjetoEditPageState createState() {
    return ProjetoEditPageState();
  }
}

class ProjetoEditPageState extends State<ProjetoEditPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerDateInicio = new TextEditingController();
  TextEditingController _controllerDateTermino = new TextEditingController();

  Projeto? obj;
  String dropdownValue = 'One';
  List<Usuario> lista = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obj = widget.obj;
    _controllerDateInicio.text = obj!.dataInicio == null
        ? ""
        : DateFormat("dd-MM-yyyy HH:mm").format(obj!.dataInicio!);

    _controllerDateTermino.text = obj!.dataTermino == null
        ? ""
        : DateFormat("dd-MM-yyyy HH:mm").format(obj!.dataTermino!);

    //_controllerResponsavel
    _atualizarLista();
  }

  void _atualizarLista() {
    lista.clear();
    UsusarioApi.getList().then((value) => {
          setState(() {
            lista.addAll(value);
          })
        });
  }

  void _salvar() {
    if (widget.obj.id == null) {
      ProjetoApi.inserir(widget.obj)
          .then((value) => {Navigator.of(context).pop()})
          .onError((error, stackTrace) => {print(error)});
    } else {
      ProjetoApi.alterar(widget.obj)
          .then((value) => {
            Navigator.of(context).pop()
          })
          .onError((error, stackTrace) => {
            print(error)
          });
    }
  }

  void _excluir() {
    ProjetoApi.excluir(widget.obj)
        .then((value) => {Navigator.of(context).pop()})
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.toString())),
              )
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.obj.titulo,
                  maxLength: 60,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Informe o titulo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'informe seu titulo';
                    }
                    widget.obj.titulo = value;
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: widget.obj.descricao,
                  maxLength: 200,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Informe a descrição'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a descrição';
                    }
                    widget.obj.descricao = value;
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerDateInicio,
                  keyboardType: TextInputType.none,
                  // initialValue:  obj!.dataHoraCad == null ? null : DateFormat("yyyy-MM-dd").format(obj!.dataHoraCad!),
                  maxLength: 100,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Data Inicio'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Data Inicio';
                    }
                    // widget.obj.dataHoraCad = value;
                    return null;
                  },
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onChanged: (date) {
                      setState(() {
                        obj!.dataInicio = date;
                        widget.obj.dataInicio = date;
                      });
                    }, onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        obj!.dataInicio = date;
                        widget.obj.dataInicio = date;
                        _controllerDateInicio.text =
                            DateFormat("dd-MM-yyyy HH:mm")
                                .format(obj!.dataInicio!);
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.pt);
                  },
                ),
                TextFormField(
                  controller: _controllerDateTermino,
                  keyboardType: TextInputType.none,
                  // initialValue:  obj!.dataHoraCad == null ? null : DateFormat("yyyy-MM-dd").format(obj!.dataHoraCad!),
                  maxLength: 100,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Data Término'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Data Término';
                    }
                    // widget.obj.dataHoraCad = value;
                    return null;
                  },
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onChanged: (date) {
                      setState(() {
                        obj!.dataTermino = date;
                        widget.obj.dataTermino = date;
                      });
                    }, onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        obj!.dataTermino = date;
                        widget.obj.dataTermino = date;
                        _controllerDateTermino.text =
                            DateFormat("dd-MM-yyyy HH:mm")
                                .format(obj!.dataTermino!);
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.pt);
                  },
                ),
                TextFormField(
                  initialValue: widget.obj.nomeDemandante,
                  maxLength: 200,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Informe o Demandante'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o Demandante';
                    }
                    widget.obj.nomeDemandante = value;
                    return null;
                  },
                ),








DropdownButton<Usuario>(
                     value:  widget.obj.responsavel,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (Usuario? newValue) {
                        print(newValue!.id);
                        widget.obj.responsavel = newValue;
                        setState(() {
                          //dropdownValue = newValue!;
                        });
                      },
                      items: lista
                          .map<DropdownMenuItem<Usuario>>((Usuario value) {
                        return DropdownMenuItem<Usuario>(
                          value: value,
                          child: Text(value.nome!),
                        );
                      }).toList(),
                    ),















                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _salvar();
                          GFToast.showToast(
                            'Projeto salvo com sucesso!',
                            context,
                          );
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                    ElevatedButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Excluir usuario'),
                          content: const Text(
                              'Voce tem certeza que deseja excluir este usuario?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Cancelar'),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  _excluir();
                                  Navigator.pop(context);
                                  GFToast.showToast(
                                    'Usuário excluído com sucesso!',
                                    context,
                                  );
                                }
                              },
                              child: const Text('Excluir'),
                            ),
                          ],
                        ),
                      ),
                      child: const Text('Excluir'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
