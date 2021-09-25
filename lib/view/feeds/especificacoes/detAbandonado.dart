import 'package:flutter/material.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/view/mapa/mapFixo.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class DetRua extends StatefulWidget {
  final Map<String, dynamic> dd;
  DetRua({Key key, @required this.dd}) : super(key: key);
  @override
  _DetRuaState createState() => _DetRuaState();
}

class _DetRuaState extends State<DetRua> {
  final Distance distance = new Distance();
  var x;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dd['raca']),
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
                            widget.dd['caracteristicas'],
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FlatButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapaFixo(
                                    lat: widget.dd['local']['lat'],
                                    long: widget.dd['local']['long'],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.map,
                              color: Colors.green,
                            ),
                            label: Text(
                              'Local de Abandono',
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
      return 'Não informado';
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
