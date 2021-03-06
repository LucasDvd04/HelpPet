import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class PerfilAdocao extends StatefulWidget {
  final Map<String, dynamic> dd;
  PerfilAdocao({Key key, @required this.dd}) : super(key: key);
  @override
  _PerfilAdocaoState createState() => _PerfilAdocaoState();
}

class _PerfilAdocaoState extends State<PerfilAdocao> {
  final Distance distance = new Distance();
  var x;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dd['nome']),
      ),
      body: buildPage(context),
    );
  }

  Widget buildPage(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    return Container(
      decoration: buildDecoration(),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 350,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.dd['ftReference']),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: getValue(size.width * 0.50, 900, 10),
              height: getValue(size.height * 0.40, 900, 0),
              decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(35)),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            widget.dd['nome'],
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Indie-Flower"),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Especie: ' +
                                especie(
                                  widget.dd['especie'],
                                ),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Indie-Flower"),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Sexo: ' +
                                sexo(
                                  widget.dd['sexo'],
                                ),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Indie-Flower"),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Idade: ' + widget.dd['idade'] + ' Anos',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Indie-Flower"),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Vacinas: ' +
                                vacinas(
                                  widget.dd['vacina'],
                                ),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Indie-Flower"),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            'Castrado: : ' +
                                castracao(
                                  widget.dd['castracoes'],
                                ),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Indie-Flower"),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FlatButton.icon(
                            onPressed: () {
                              launchWhatsApp();
                            },
                            icon: FaIcon(FontAwesomeIcons.whatsapp),
                            label: Text(
                              widget.dd['nmResponsavel'],
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Indie-Flower"),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  especie(especie) {
    if (especie == 'C') {
      return 'Cachorro';
    } else if (especie == 'G') {
      return 'Gato';
    } else {
      return 'N??o informado';
    }
  }

  sexo(sexo) {
    if (sexo == 'macho') {
      return 'Masculino';
    } else if (sexo == 'femea') {
      return 'Feminino';
    } else {
      return 'N??o informado';
    }
  }

  vacinas(vacina) {
    if (vacina == true) {
      return 'Em dia';
    } else if (vacina == false) {
      return 'Pendente';
    } else {
      return 'N??o informado';
    }
  }

  castracao(cast) {
    if (cast == true) {
      return 'Sim';
    } else if (cast == false) {
      return 'N??o';
    } else {
      return 'N??o informado';
    }
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: widget.dd['telContato'],
      text: "Ola, eu vi seu anuncio no HelpPet",
    );
    await launch('$link');
  }
}
