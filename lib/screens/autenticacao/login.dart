import 'dart:ui';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/screens/autenticacao/register.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
  TextEditingController _cpfcontroller = TextEditingController();
  TextEditingController _senhacontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 40),
          child: SingleChildScrollView(child: _construirForm(context)),
        ),
        backgroundColor: Color.fromRGBO(71, 161, 56, 1));
  }

  Widget _construirForm(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/bytebank_logo.png',
              width: 200,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 300,
              height: 455,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Faça seu login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'CPF',
                      ),
                      maxLength: 14,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      keyboardType: TextInputType.number,
                      controller: _cpfcontroller,
                      validator: (value) {
                        if (value?.length == 0) return 'Informe o CPF';
                        if (value!.length < 14) return 'CPF Inválido';
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                      ),
                      maxLength: 255,
                      keyboardType: TextInputType.text,
                      controller: _senhacontroller,
                      validator: (value) {
                        if (value?.length == 0) return 'Informe uma Senha';
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ),
                                (route) => false);
                          }
                        },
                        child: Text(
                          'CONTINUAR',
                          style:
                              TextStyle(color: Color.fromRGBO(71, 161, 56, 1)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Esqueci minha senha > ',
                      style: TextStyle(color: Color.fromRGBO(71, 161, 56, 1)),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ));
                      },
                      child: Text(
                        'Criar uma conta',
                        style: TextStyle(color: Color.fromRGBO(71, 161, 56, 1)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //SizedBox(height: 20,)
        ],
      ),
    );
  }
}
