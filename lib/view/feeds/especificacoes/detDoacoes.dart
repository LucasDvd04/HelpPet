import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class DetDoacao extends StatefulWidget {
  final Map<String, dynamic> dd;
  DetDoacao({Key key, @required this.dd}) : super(key: key);
  @override
  _DetDoacaoState createState() => _DetDoacaoState();
}

class _DetDoacaoState extends State<DetDoacao> {
  final Distance distance = new Distance();
  var x;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dd['tipo']),
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
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                widget.dd['descricao'],
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Indie-Flower"),
                              )),
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
                )),
          ),
        ],
      ),
    );
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: widget.dd['telContato'],
      text: "Ola, eu vi seu anuncio no HelpPet",
    );
    await launch('$link');
  }
}
