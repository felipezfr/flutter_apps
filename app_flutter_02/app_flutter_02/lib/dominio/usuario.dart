class Usuario {
  String? id;
  String? nome;
  String? email;
  String? celular;
  String? senha;
  DateTime? dataHoraCad;

  Usuario();
  Usuario.all(this.id, this.nome, this.email, this.celular, this.senha,
      this.dataHoraCad);

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario.all(
      json['_id'], 
      json['nome'], 
      json['email'],
      json['celular'], 
      json['senha'], 
      json['dataHoraCad'] == null ? null : DateTime.parse(json['dataHoraCad'])
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'nome': nome,
        'email': email,
        'celular': celular,
        'senha': senha,
        'dataHoraCad': dataHoraCad
      };
}
