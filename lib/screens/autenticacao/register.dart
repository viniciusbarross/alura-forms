import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/components/biometria.dart';
import 'package:bytebank/models/cliente.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  //step 1
  final _formUserData = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();

  final _formUserAddress = GlobalKey<FormState>();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradourController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  final _formUserAuth = GlobalKey<FormState>();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cadastro cliente'),
      ),
      body: Consumer<Cliente>(
        builder: (context, value, child) {
          return Stepper(
            controlsBuilder: (context, {onStepCancel, onStepContinue}) {
              return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: onStepContinue,
                          child: Text(
                            'Salvar',
                            style: TextStyle(color: Colors.white),
                          )),
                      Padding(padding: EdgeInsets.only(right: 20)),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: onStepCancel,
                          child: Text('Voltar',
                              style: TextStyle(color: Colors.white)))
                    ],
                  ));
            },
            steps: _construirSteps(context, value),
            currentStep: value.stepAtual,
            onStepContinue: () {
              final functions = [_salvarStep1, _salvarStep2, _salvarStep3];

              return functions[value.stepAtual](context);
            },
            onStepCancel: () {
              value.stepAtual = value.stepAtual > 0 ? value.stepAtual - 1 : 0;
            },
          );
        },
      ),
    );
  }

  void _salvarStep1(context) {
    if (_formUserData.currentState!.validate()) {
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.nome = _nomeController.text;

      _proximoStep(context);
    }
  }

  void _salvarStep2(context) {
    if (_formUserAddress.currentState!.validate()) {
      _proximoStep(context);
    }
  }

  void _salvarStep3(context) {
    if (_formUserAuth.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      Provider.of<Cliente>(context).imagemRG = null;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
          (route) => false);
    }
  }

  void _salvar(BuildContext context) {
    Provider.of<Cliente>(context, listen: false).nome = _nomeController.text;
  }

  _proximoStep(context) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    irPara(cliente.stepAtual + 1, cliente);
  }

  List<Step> _construirSteps(BuildContext context, Cliente cliente) {
    List<Step> steps = [
      Step(
        title: Text('Dados'),
        isActive: cliente.stepAtual >= 0,
        content: Form(
          key: _formUserData,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                keyboardType: TextInputType.text,
                maxLength: 255,
                validator: (value) {
                  if (!value!.contains(' '))
                    return 'Informe pelo menos um sobrenome';
                  if (value.length < 3) return 'Nome inválido';
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.text,
                maxLength: 255,
                validator: (value) {
                  if (!value!.contains('@') || !value.contains('.'))
                    return 'Email inválido';

                  if (value.length < 3) return 'Email inválido';
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
                maxLength: 14,
                validator: (value) =>
                    Validator.cpf(value) ? 'CPF Inválido' : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter()
                ],
              ),
              TextFormField(
                controller: _celularController,
                decoration: InputDecoration(labelText: 'Celular'),
                keyboardType: TextInputType.number,
                maxLength: 15,
                validator: (value) =>
                    Validator.phone(value) ? 'Celular inválido' : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
              ),
              DateTimePicker(
                controller: _nascimentoController,
                type: DateTimePickerType.date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Nascimento',
                dateMask: 'dd/MM/yyyy',
              ),
            ],
          ),
        ),
      ),
      Step(
          title: Text('Endereço'),
          isActive: cliente.stepAtual >= 1,
          content: Form(
              child: Form(
            key: _formUserAddress,
            child: Column(
              children: [
                TextFormField(
                  controller: _cepController,
                  decoration: InputDecoration(labelText: 'CEP'),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) =>
                      Validator.cep(value) ? 'CEP inválido' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(ponto: false)
                  ],
                ),
                DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(labelText: 'Estado'),
                  items: Estados.listaEstadosSigla.map((String estado) {
                    return DropdownMenuItem(
                      child: Text(estado),
                      value: estado,
                    );
                  }).toList(),
                  onChanged: (String? novoEstadoSelecionado) {
                    _estadoController.text = novoEstadoSelecionado ?? '';
                  },
                  validator: (value) {
                    if (value == null) return 'Selecione um estado';
                  },
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _cidadeController,
                  decoration: InputDecoration(labelText: 'Cidade'),
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.length < 3) return 'Cidade inválida';
                  },
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _bairroController,
                  decoration: InputDecoration(labelText: 'Bairro'),
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.length < 3) return 'Bairro inválido';
                  },
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _logradourController,
                  decoration: InputDecoration(labelText: 'Logradouro'),
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.length < 3) return 'Logradouro inválido';
                  },
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _numeroController,
                  decoration: InputDecoration(labelText: 'Número'),
                  keyboardType: TextInputType.number,
                  maxLength: 255,
                ),
              ],
            ),
          ))),
      Step(
          title: Text('Autenticação'),
          isActive: cliente.stepAtual >= 2,
          content: Form(
              key: _formUserAuth,
              child: Column(
                children: [
                  TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(labelText: 'Senha'),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    maxLength: 255,
                    validator: (value) {
                      if (value!.length < 8) return 'Senha muito curta';
                    },
                  ),
                  TextFormField(
                    controller: _confirmaSenhaController,
                    decoration: InputDecoration(labelText: 'Confirmação senha'),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    maxLength: 255,
                    validator: (value) {
                      if (_confirmaSenhaController.text !=
                          _senhaController.text) return 'Senhas não conferem';
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Para prosseguir com seu cadastro é necessário que \n tenhamos uma foto do seu RG',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () => _capturarRg(cliente),
                      child: Text('Tirar foto do meu RG')),
                  _isSentRG(context) ? _imagemRG(context) : _pedidoRG(context),
                  Biometria()
                ],
              )))
    ];
    return steps;
  }

  void irPara(int step, Cliente cliente) {
    cliente.stepAtual = step;
  }

  _capturarRg(Cliente cliente) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    cliente.imagemRG = pickedImage != null ? File(pickedImage.path) : null;
  }

  _imagemRG(BuildContext context) =>
      Image.file(Provider.of<Cliente>(context).imagemRG!);

  _isSentRG(BuildContext context) =>
      Provider.of<Cliente>(context).imagemRG != null;

  _pedidoRG(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Text('Foto do RG pendente',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }
}
