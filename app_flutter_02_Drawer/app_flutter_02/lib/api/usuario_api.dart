import 'dart:convert';

import 'package:app_flutter_02/dominio/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioApi {
  static const _apiBase = 'http://localhost:3000/api';
  // para liberar acesso a porta 3000 pelo emulador
  //    adb reverse tcp:3000 tcp:3000
  // precisa liberar a origem no cors da api
  //    routes.use(cors({origin: '*'}));

  static Future getList() async {
    final response = await http.get(Uri.parse(_apiBase + '/usuarios'));
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao listar usando a API' + response.body.toString());
    }
  }

  static Future<Usuario> inserir(Usuario obj) async {
    final response = await http.post(
      Uri.parse(_apiBase + '/usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(obj.toJson()),
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao inserir pela API. ' + response.body.toString());
    }
  }

  static Future<Usuario> alterar(Usuario obj) async {
    final response = await http.put(
      Uri.parse(_apiBase + '/usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(obj.toJson()),
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao inserir pela API.' + response.body.toString());
    }
  }

  static Future excluir(Usuario obj) async {
    final response = await http
        .delete(Uri.parse(_apiBase + '/usuarios/' + obj.id.toString()));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao excluir pela API.' + response.body.toString());
    }
  }
}
