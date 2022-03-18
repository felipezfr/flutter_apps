import 'package:app_flutter_02/dominio/projeto.dart';
import 'package:app_flutter_02/dominio/usuario.dart';

class Atividade {
  String? id;
  String? titulo;
  String? descricao;
  DateTime? dataInicio;
  DateTime? dataTermino;
  Usuario? responsavel;
  Projeto? projeto;

  Atividade();
  Atividade.all(
    this.id,
    this.titulo,
    this.descricao,
    this.dataInicio,
    this.dataTermino,
    this.responsavel,
    this.projeto,
  );

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade.all(
      json['_id'],
      json['titulo'],
      json['descricao'],
      json['dataInicio'] == null ? null : DateTime.parse(json['dataInicio']),
      json['dataTermino'] == null ? null : DateTime.parse(json['dataTermino']),
      json['responsavel'] == null
          ? null
          : Usuario.fromJson(json['responsavel']),
      json['projeto'] == null ? null : Projeto.fromJson(json['projeto']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'titulo': titulo,
        'descricao': descricao,
        'dataInicio': dataInicio.toString() + "Z",
        'dataTermino': dataTermino.toString() + "Z",
        'responsavel': responsavel != null ? responsavel!.toJson() : null,
        'projeto': projeto != null ? projeto!.toJson() : null
      };
}
