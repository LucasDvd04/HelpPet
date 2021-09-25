import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

double getValue(double value, double max, double min) {
  if (value < max && value > min) {
    return value;
  } else if (value < min) {
    return min;
  } else {
    return max;
  }
}

TextStyle textoPadraoLinks(context) {
  //função responsavel por definir o tamanho dos links de acordo com o tamanho da tela
  var mediaQuery = MediaQuery.of(context);
  var size = mediaQuery.size;
  var fontSize = size.width * 0.027;
  return TextStyle(
      fontSize: getValue(fontSize, 25, 5), fontWeight: FontWeight.bold);
}

TextStyle textoPadrao(context) {
  //função responsavel por definir o tamanho da fonte de acordo com o tamanho da tela
  var mediaQuery = MediaQuery.of(context);
  var size = mediaQuery.size;
  var fontSize = size.width * 0.040;
  return TextStyle(
      fontSize: getValue(fontSize, 30, 12),
      fontWeight: FontWeight.bold,
      fontFamily: "Indie-Flower");
}

TextStyle textoPadraoBtn(context) {
  //função responsavel por definir as caracteriscas do botão de acordo com o tamanho da tela
  var mediaQuery = MediaQuery.of(context);
  var size = mediaQuery.size;
  var fontSize = size.width * 0.045;
  return TextStyle(
      fontSize: getValue(fontSize, 30, 12),
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: "Indie-Flower");
}

double logoPadrao(context) {
  //função responsavel por definir as caracteristicas da logo de acordo com o tamanho da tela
  var mediaQuery = MediaQuery.of(context);
  var size = mediaQuery.size;
  var imgSize = size.width * 0.80;

  return imgSize;
}

double heigthIndexOp(context) {
  //função responsavel por definir as caracteristicas da logo de acordo com o tamanho da tela
  var mediaQuery = MediaQuery.of(context);
  var size = mediaQuery.size;
  var larg = size.height;

  return larg;
}

double widtchIndexOp(context) {
  //função responsavel por definir as caracteristicas da logo de acordo com o tamanho da tela
  var mediaQuery = MediaQuery.of(context);
  var size = mediaQuery.size;
  var alt = size.width;

  return alt;
}

double boxForm(context) {
  //função responsavel por definir o tamanho do container de informações de acordo com o tamanho da tela
  var mediaQuery = MediaQuery.of(context);
  var size = mediaQuery.size;
  var imgSize = size.width * 0.40;

  return imgSize;
}
