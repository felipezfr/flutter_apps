import 'package:app_flutter_02/dominio/usuario.dart';

class Projeto {
  String? id;
  String? titulo;
  String? descricao;
  DateTime? dataInicio;
  DateTime? dataTermino;
  String? nomeDemandante;
  Usuario? responsavel;

  Projeto();
  Projeto.all(
    this.id,
    this.titulo,
    this.descricao,
    this.dataInicio,
    this.dataTermino,
    this.nomeDemandante,
    this.responsavel,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Projeto && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory Projeto.fromJson(Map<String, dynamic> json) {
    return Projeto.all(
      json['_id'],
      json['titulo'],
      json['descricao'],
      json['dataInicio'] == null ? null : DateTime.parse(json['dataInicio']),
      json['dataTermino'] == null ? null : DateTime.parse(json['dataTermino']),
      json['nomeDemandante'],
      json['responsavel'] == null ? null : Usuario.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'titulo': titulo,
        'descricao': descricao,
        'dataInicio': dataInicio.toString() + "Z",
        'dataTermino': dataInicio.toString() + "Z",
        'nomeDemandante': nomeDemandante,
        'responsavel': responsavel != null ? responsavel!.toJson() : null
      };
}
