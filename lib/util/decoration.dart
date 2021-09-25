import 'package:flutter/widgets.dart';

BoxDecoration buildDecoration() {
  return BoxDecoration(
      //Caixa conde estão as caracteristicas de background
      gradient: LinearGradient(
          //opção de background linear com 2 ou mais cores
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [azul, rosa]));
}

Color azul = Color(0xff87CEFA);
Color rosa = Color(0xffFFE4E1);
