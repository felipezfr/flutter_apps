import 'package:app_flutter_02/dominio/usuario.dart';
import 'package:app_flutter_02/api/login_api.dart';
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

  Usuario user_login = Usuario();

  void _processar(){
    Login.Logar(user_login)
          .then((value) => {Navigator.of(context).pushNamed('/home'),
          ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Bem vindo")),
                    )})
          .onError((error, stackTrace) => {ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.toString())),
              )});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Informe o e-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'informe seu e-mail';
                  }
                  user_login.email = value;
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Informe a senha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua senha';
                  }
                  user_login.senha = value;
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _processar();
                  }
                },
                child: const Text('Logar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
