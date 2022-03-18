import 'dart:convert';
import 'package:app_flutter_02/dominio/projeto.dart';
import 'package:http/http.dart' as http;

class ProjetoApi {
  static const _apiBase = 'http://localhost:3000/api';
  // para liberar acesso a porta 3000 pelo emulador
  //    adb reverse tcp:3000 tcp:3000
  // precisa liberar a origem no cors da api
  //    routes.use(cors({origin: '*'}));

  static Future getList() async {
    final response = await http.get(Uri.parse(_apiBase + '/projetos'));
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((json) => Projeto.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao listar usando a API' + response.body.toString());
    }
  }

  static Future getListById(String id) async {
    final response =
        await http.get(Uri.parse(_apiBase + '/projetos/listar/' + id));
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((json) => Projeto.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao listar usando a API' + response.body.toString());
    }
  }

  static Future<Projeto> inserir(Projeto obj) async {
    final response = await http.post(
      Uri.parse(_apiBase + '/projetos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(obj.toJson()),
    );

    if (response.statusCode == 200) {
      return Projeto();
    } else {
      throw Exception('Erro ao inserir pela API. ' + response.body.toString());
    }
  }

  static Future<Projeto> alterar(Projeto obj) async {
    final response = await http.put(
      Uri.parse(_apiBase + '/projetos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(obj.toJson()),
    );

    if (response.statusCode == 200) {
      return Projeto();
    } else {
      throw Exception('Erro ao inserir pela API.' + response.body.toString());
    }
  }

  static Future excluir(Projeto obj) async {
    final response = await http
        .delete(Uri.parse(_apiBase + '/projetos/' + obj.id.toString()));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao excluir pela API.' + response.body.toString());
    }
  }
}
