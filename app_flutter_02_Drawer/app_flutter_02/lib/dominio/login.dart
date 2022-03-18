String _id = '';
String _nome = '';

class Login {
  String _email = '';
  String _password = '';

  static String _idLogado = '';

  Login();

  Login.all(this._email, this._password);

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login.all(
      json['email'],
      json['senha'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': _email,
        'senha': _password,
      };

  Map<String, dynamic> setToken(Map<String, dynamic> decodedToken) => {
        decodedToken['_id']: _id,
        decodedToken['nome']: _nome,
      };

  factory Login.getToken(Map<String, dynamic> decodedToken) {
    return Login.all(
      decodedToken['_id'],
      decodedToken['nome'],
    );
  }

  String get email {
    return _email;
  }

  set email(String email) {
    _email = email;
  }

  String get senha {
    return _password;
  }

  set senha(String password) {
    _password = password;
  }

  // String get nomeLogado {
  //   return _nome;
  // }

  // set nomeLogado(String nome) {
  //   _password = nome;
  // }

  static String get idLogado {
    return _idLogado;
  }

  static set idLogado(String id) {
    _idLogado = id;
  }

  // @override
  // toString() {
  //   return _email + " " + _password.toString();
  // }

  // int getDiasVividos() {
  //   return _password * 365;
  // }

  // String getResultado() {
  //   return '$_email, Você viveu aproximadamente' +
  //       getDiasVividos().toString() +
  //       ' dias';
  // }

  // String get resultado {
  //   return '$_email, Você viveu aproximadamente' +
  //       getDiasVividos().toString() +
  //       ' dias';
  // }
}
