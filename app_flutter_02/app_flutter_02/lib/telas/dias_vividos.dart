import 'package:app_flutter_02/dominio/pessoa.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class DiasVividosPage extends StatefulWidget {
  const DiasVividosPage({Key? key}) : super(key: key);

  @override
  DiasVividosPageState createState() {
    return DiasVividosPageState();
  }
}

class DiasVividosPageState extends State<DiasVividosPage> {
  final _formKey = GlobalKey<FormState>();

  Pessoa _p = Pessoa();
  String _resultado = '';

  void _processar(){
    setState(() {
     String aux = _p.getResultado(); 
      _resultado = _p.resultado;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dias Vividos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Informe o nome'),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'informe seu nome';
                  }
                  _p.nome = value;
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Informe a idade'),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a sua idade';
                  }
                  _p.idade = int.parse(value);
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    _processar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(_resultado)),
                    );
                  }
                },
                child: const Text('Processar'),
              ),
              Text(_resultado)
            ],
          ),
        ),
      ),
    );
  }
}
