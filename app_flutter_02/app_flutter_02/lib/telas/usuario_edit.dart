import 'package:app_flutter_02/api/usuario_api.dart';
import 'package:app_flutter_02/dominio/pessoa.dart';
import 'package:app_flutter_02/dominio/usuario.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class UsuarioEditPage extends StatefulWidget {
  const UsuarioEditPage({Key? key, required this.obj}) : super(key: key);
  // Este será o objeto que estará sendo editado. Novo ou um existente
  final Usuario obj;

  @override
  UsuarioEditPageState createState() {
    return UsuarioEditPageState();
  }
}

class UsuarioEditPageState extends State<UsuarioEditPage> {
  final _formKey = GlobalKey<FormState>();

  void _salvar() {
    if (widget.obj.id == null) {
      UsusarioApi.inserir(widget.obj)
          .then((value) => {Navigator.of(context).pop()})
          .onError((error, stackTrace) => {});
    } else {
      UsusarioApi.alterar(widget.obj)
          .then((value) => {Navigator.of(context).pop()})
          .onError((error, stackTrace) => {});
    }
  }

  void _excluir(){
    UsusarioApi.excluir(widget.obj)
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.obj.nome,
                maxLength: 60,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Informe o nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'informe seu nome';
                  }
                  widget.obj.nome = value;
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.obj.email,
                maxLength: 100,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Informe o e-mail'),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o e-mail';
                  }
                  widget.obj.email = value;
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                initialValue: widget.obj.celular,
                maxLength: 100,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Informe o celular'),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o celular';
                  }
                  widget.obj.celular = value;
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        _salvar();
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        _excluir();
                      }
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
    );
  }
}
