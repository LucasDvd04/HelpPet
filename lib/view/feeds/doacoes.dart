import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/util/location.dart';
import 'package:helppet/view/feeds/especificacoes/detDoacoes.dart';

class DoacoesDiponiveis extends StatefulWidget {
  @override
  _DoacoesDiponiveisState createState() => _DoacoesDiponiveisState();
}

class _DoacoesDiponiveisState extends State<DoacoesDiponiveis> {
  Location l = new Location();

  @override
  Widget build(BuildContext context) {
    l.postionActual();
    return Scaffold(
      appBar: AppBar(
        title: Text('Itens disponiveis'),
      ),
      body: corp(context),
    );
  }

  Widget corp(BuildContext context) {
    return Container(
      decoration: buildDecoration(),
      child: _animais(context),
    );
  }

  Widget _animais(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ItemDoacao')
          .where('lat', isGreaterThanOrEqualTo: l.latMin)
          .where('lat', isLessThanOrEqualTo: l.latMax)
          .where('long', isGreaterThanOrEqualTo: l.longMin)
          .where('long', isLessThanOrEqualTo: l.longMax)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: CircularProgressIndicator());

          default:
            return new PageView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black54, BlendMode.darken),
                                    image:
                                        NetworkImage(document['ftReference']),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20)),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetDoacao(dd: document.data),
                                  ),
                                );
                              },
                              child: Text(
                                document['descricao'],
                                style: textoPadraoBtn(context),
                              ),
                            )),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }
}
