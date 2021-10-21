import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  late String? _nome;
  late String _email;
  late String _cpf;
  late String _celular;
  late String _endereco;
  late String _bairro;
  late String _cidade;
  late String _nascimento;
  late String _cep;
  late String _logradouro;

  late String _senha;

  int stepAtual = 0;

  get getStepAtual => this.stepAtual;

  set setStepAtual(stepAtual) => this.stepAtual = stepAtual;

  get nome => this._nome;

  set nome(value) {
    this._nome = value;
    notifyListeners();
  }

  get email => this._email;

  set email(value) => this._email = value;

  get cpf => this._cpf;

  set cpf(value) => this._cpf = value;

  get celular => this._celular;

  set celular(value) => this._celular = value;

  get endereco => this._endereco;

  set endereco(value) => this._endereco = value;

  get bairro => this._bairro;

  set bairro(value) => this._bairro = value;

  get cidade => this._cidade;

  set cidade(value) => this._cidade = value;

  get nascimento => this._nascimento;

  set nascimento(value) => this._nascimento = value;

  get cep => this._cep;

  set cep(value) => this._cep = value;

  get logradouro => this._logradouro;

  set logradouro(value) => this._logradouro = value;

  get senha => this._senha;

  set senha(value) => this._senha = value;
}
