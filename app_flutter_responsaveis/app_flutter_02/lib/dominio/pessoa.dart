class Pessoa {
  String _nome = '';
  int _idade = 0;

  Pessoa();
  Pessoa.initAll(this._nome, this._idade);
  Pessoa.initNome(String nome) {
    _nome = nome;
    _idade = 0;
  }
  String get nome {
    return _nome;
  }

  set nome(String nome) {
    _nome = nome;
  }

  int get idade {
    return _idade;
  }

  set idade(int idade) {
    _idade = idade;
  }  

  @override
  toString() {
    return _nome + " " + _idade.toString();
  }

  int getDiasVividos() {
    return _idade * 365;
  }

  String getResultado() {
    return '$_nome, Você viveu aproximadamente' +
        getDiasVividos().toString() +
        ' dias';
  } 


  String get resultado {
    return '$_nome, Você viveu aproximadamente' +
        getDiasVividos().toString() +
        ' dias';
  }  
}
