import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helppet/util/decoration.dart';

class Denuncia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Como denunciar?')),
        body: buildDenuncia(context));
  }

  Widget buildDenuncia(BuildContext context) {
    return Container(
      decoration: buildDecoration(),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('Denuncie',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Indie-Flower")),
            ),
            Center(
              child: FlatButton.icon(
                  onPressed: () => {},
                  icon: FaIcon(FontAwesomeIcons.phoneAlt),
                  label: Text(
                    '190 - Policia Militar',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Indie-Flower"),
                  )),
            ),
            Center(
              child: FlatButton.icon(
                  onPressed: () => {},
                  icon: FaIcon(FontAwesomeIcons.phoneAlt),
                  label: Text(
                    '181 - Disk-Denuncia',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Indie-Flower"),
                  )),
            ),
            Center(
              child: FlatButton.icon(
                  onPressed: () => {},
                  icon: FaIcon(FontAwesomeIcons.phoneAlt),
                  label: Text(
                    '0800 61 8080 - Ibama',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Indie-Flower"),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
