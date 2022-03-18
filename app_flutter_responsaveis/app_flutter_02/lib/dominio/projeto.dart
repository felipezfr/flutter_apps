import 'package:app_flutter_02/dominio/usuario.dart';

class Projeto {
  String? id;
  String? titulo;
  String? descricao;
  Usuario? responsavel;
  DateTime? dataInicio;
  DateTime? dataTermino;
  String? nomeDemandante;

  Projeto();
  Projeto.all(this.id, this.titulo, this.descricao, this.dataInicio,
      this.dataTermino, this.nomeDemandante, this.responsavel);

  factory Projeto.fromJson(Map<String, dynamic> json) {
    return Projeto.all(
        json['_id'],
        json['titulo'],
        json['descricao'],
        json['dataInicio'] == null ? null : DateTime.parse(json['dataInicio']),
        json['dataTermino'] == null
            ? null
            : DateTime.parse(json['dataTermino']),
        json['nomeDemandante'],
        json['responsavel'] == null
            ? null
            : Usuario.fromJson(json['responsavel']));
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'titulo': titulo,
        'descricao': descricao,
        'dataInicio': dataInicio != null ? dataInicio.toString() + "Z" : null,
        'dataTermino':
            dataTermino != null ? dataTermino.toString() + "Z" : null,
        'nomeDemandante': nomeDemandante,
        'responsavel': responsavel != null ? responsavel!.toJson() : null
      };
}
