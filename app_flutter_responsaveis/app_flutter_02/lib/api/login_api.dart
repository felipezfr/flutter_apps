import 'dart:convert';

import 'package:app_flutter_02/dominio/usuario.dart';
import 'package:http/http.dart' as http;

class Login {
  static const _apiBase = 'http://localhost:3000/api';

  static Future Logar(Usuario obj) async {
    final response = await http.post(Uri.parse(_apiBase + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email":obj.email, "senha":obj.senha}),);
    if (response.statusCode == 200) {
      //Então tá blz
      //Pegaria o token??
    } else {
      throw Exception('Erro ao logar ' + response.body.toString());
    }
  }
}
