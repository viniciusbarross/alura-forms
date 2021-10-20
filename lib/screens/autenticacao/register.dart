import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradourController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cadastro cliente'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome'),
                    keyboardType: TextInputType.text,
                    maxLength: 255,
                    validator: (value) {
                      if (value!.contains(' '))
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
                    validator: (value) {
                      if (value!.length != 14) return 'CPF inválido';
                    },
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
                    validator: (value) {
                      if (value!.length < 11) return 'Celular inválido';
                    },
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
                    validator: (value) {
                      return 'Data inválida';
                    },
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _cepController,
                    decoration: InputDecoration(labelText: 'CEP'),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value!.length < 10) return 'CEP inválido';
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter()
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
                    keyboardType: TextInputType.number,
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
                  ElevatedButton(onPressed: () {}, child: Text('Continuar'))
                ],
              ),
            )),
      ),
    );
  }
}
