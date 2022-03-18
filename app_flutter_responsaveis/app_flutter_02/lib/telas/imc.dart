import 'package:app_flutter_02/dominio/pessoa.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  ImcPageState createState() {
    return ImcPageState();
  }
}

class ImcPageState extends State<ImcPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();


  Pessoa _p = Pessoa();
  // String _resultado = '';

  // void _processar(){
  //   setState(() {
  //     String aux = _p.getResultados();
  //     _resultado = _p.resultado;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Informe seu nome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu nome';
                    }
                    _p.nome = value;
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Informe a idade',
                  ),
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
                      _p.getDiasVividos();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(_p.resultado)),
                      );
                    }
                  },
                  child: const Text('Processar'),
                ),
                Text(_p.resultado)
              ],
            )),
      ),
    );
  }
}
