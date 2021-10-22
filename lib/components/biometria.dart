import 'package:bytebank/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Biometria extends StatefulWidget {
  @override
  State<Biometria> createState() => _BiometriaState();
}

class _BiometriaState extends State<Biometria> {
  final LocalAuthentication _autenticacaolocal = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _biometriaDisponivel(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container();
          case ConnectionState.done:
            return (Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: [
                  Text(
                    'Detectamos que voce possui sensor biometrico. Deseja cadastrar acesso biométrico?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await _autenticarCliente(context);
                      },
                      child: Text('Habilitar biometria'))
                ],
              ),
            ));
          default:
            return Container();
        }
      },
    );
  }

  Future<bool> _biometriaDisponivel() async {
    try {
      return await _autenticacaolocal.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _autenticarCliente(context) async {
    bool autenticado = false;
    autenticado = await _autenticacaolocal.authenticate(
        localizedReason:
            'Por favor autentique-se via biometria para acessar o bytebank',
        biometricOnly: true,
        useErrorDialogs: true);
    Provider.of<Cliente>(context).biometria = autenticado;
  }
}
