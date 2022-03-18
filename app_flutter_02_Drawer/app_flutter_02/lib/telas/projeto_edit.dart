import 'package:app_flutter_02/api/projeto_api.dart';
import 'package:app_flutter_02/api/usuario_api.dart';
import 'package:app_flutter_02/dominio/projeto.dart';
import 'package:app_flutter_02/dominio/usuario.dart';
import 'package:app_flutter_02/util/dialogos.dart';
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
    _atualizarLista();
  }

  void _atualizarLista() {
    lista.clear();
    UsuarioApi.getList().then((value) => {
          setState(() {
            lista.addAll(value);
          })
        });
  }

  void _salvar() {
    if (widget.obj.id == null) {
      ProjetoApi.inserir(widget.obj)
          .then((value) => {Navigator.of(context).pop()})
          .onError((error, stackTrace) => {});
    } else {
      ProjetoApi.alterar(widget.obj)
          .then((value) => {Navigator.of(context).pop()})
          .onError((error, stackTrace) => {});
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
        title: const Text('Projeto'),
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
                      labelText: 'Informe o titulo do Projeto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'informe o titulo do Projeto';
                    }
                    widget.obj.titulo = value;
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: widget.obj.descricao,
                  maxLength: 100,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Informe a descricao'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o e-mail';
                    }
                    widget.obj.descricao = value;
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: widget.obj.nomeDemandante,
                  maxLength: 100,
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
                  // value: widget.obj.responsavel,
                  icon: const Icon(Icons.account_box),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 5,
                    color: Colors.grey.shade500,
                  ),
                  onChanged: (Usuario? newValue) {
                    widget.obj.responsavel = newValue;
                    setState(() {
                      //dropdownValue = newValue!;
                    });
                  },
                  items: lista.map<DropdownMenuItem<Usuario>>((Usuario value) {
                    return DropdownMenuItem<Usuario>(
                      value: value,
                      child: Text(value.nome!),
                    );
                  }).toList(),
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
                      return 'Data cadastro';
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
                        obj!.dataTermino = date;
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
                      border: OutlineInputBorder(), labelText: 'Data Termino'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Data cadastro';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate())
                          {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            _salvar(),

                            if (widget.obj.id == null)
                              {
                                GFToast.showToast(
                                  'Projeto cadastrado.',
                                  context,
                                )
                              }
                            else
                              {
                                GFToast.showToast(
                                  'Dados do Projeto atualizados.',
                                  context,
                                ),
                              }
                          }
                      },
                      child: const Text('Salvar'),
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        Dialogos.showConfirmDialog(
                            context,
                            "Voce tem certeza que deseja excluir este Projeto?",
                            () => {
                                  _excluir(),
                                  GFToast.showToast(
                                    'O Projeto foi excluido',
                                    context,
                                  ),
                                }),
                      },
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
