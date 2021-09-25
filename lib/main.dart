import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppet/view/Login-Cad/LoginCadastro.dart';

void main() async {
  runApp(ControleAcesso());
}

class ControleAcesso extends StatelessWidget {
  // Parte principal que não é alterada
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remover o Debug do canto da tela
      theme: ThemeData(
        // tema principal
        primarySwatch: Colors.lightBlue, //cor principal
      ),
      home: new LoginCad(), //iniciando a tela principal que irá ter alterações
    );
  }
}
