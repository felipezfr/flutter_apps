import 'dart:convert';
import 'package:app_flutter_02/dominio/login.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginApi {
  static const _apiBase = 'http://localhost:3000/api';
  // para liberar acesso a porta 3000 pelo emulador
  //    adb reverse tcp:3000 tcp:3000
  // precisa liberar a origem no cors da api
  //    routes.use(cors({origin: '*'}));

  // static Future getList() async {
  //   final response = await http.get(Uri.parse(_apiBase + '/login'));
  //   if (response.statusCode == 200) {
  //     Iterable list = jsonDecode(response.body);
  //     return list.map((json) => Login.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Erro na API' + response.body.toString());
  //   }
  // }

  static Future<dynamic> login(Login obj) async {
    final response = await http.post(
      Uri.parse(_apiBase + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(obj),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(response.body.toString());

      return decodedToken;
    } else {
      throw Exception(
        response.body.toString(),
      );
    }
  }

  // static Future<Login> alterar(Login obj) async {
  //   final response = await http.put(
  //     Uri.parse(_apiBase + '/login'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(obj.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     return Login.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Erro ao inserir pela API.' + response.body.toString());
  //   }
  // }

  // static Future excluir(Login obj) async {
  //   final response = await http
  //       .delete(Uri.parse(_apiBase + '/login/' + obj.id.toString()));
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Erro ao excluir pela API.' + response.body.toString());
  //   }
  // }
}
