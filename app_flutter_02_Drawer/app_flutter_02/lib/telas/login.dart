import 'package:app_flutter_02/api/login_api.dart';
import 'package:app_flutter_02/dominio/login.dart';
import 'package:app_flutter_02/util/dialogos.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // String _email = '';
  // String _password = '';

  Login data = new Login();

  void _login() {
    LoginApi.login(data)
        .then((value) => {
              Login.idLogado = value['_id'],
              Navigator.of(context).pushReplacementNamed('/home'),
            })
        .onError(
          (error, stackTrace) => {
            Dialogos.showAlertDialog(context, error.toString()),
          },
        );

    // Navigator.of(context).pushNamed('/home');

    setState(() {
      // String aux = _p.getResultado();
      // _resultado = _p.resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 50, 12, 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              Text('Insira seus dados para fazer login'),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu email';
                    }
                    data.email = value;
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Senha'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a sua senha';
                    }
                    data.senha = value;
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    _login();
                  }
                },
                child: const Text('Entrar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
