import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helppet/model/AnimalDAO.dart';
import 'package:helppet/model/ItensDAO.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/util/location.dart';
import 'package:helppet/view/feeds/especificacoes/detAbandonado.dart';
import 'package:helppet/view/feeds/especificacoes/detDoacoes.dart';
import 'package:helppet/view/feeds/especificacoes/detPerdido.dart';
import 'package:helppet/view/feeds/especificacoes/perfilAdocoes.dart';
import 'package:latlong/latlong.dart';

class MinhasPubs extends StatefulWidget {
  final Map<String, dynamic> dd;
  MinhasPubs({Key key, @required this.dd}) : super(key: key);
  @override
  _MinhasPubsState createState() => _MinhasPubsState();
}

class _MinhasPubsState extends State<MinhasPubs> {
  AdocaoDAO an = new AdocaoDAO();
  Location l = new Location();

  final Distance distance = new Distance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas publicações'),
      ),
      body: corp(context),
    );
  }

  Widget corp(BuildContext context) {
    return Container(
      decoration: buildDecoration(),
      child: PageView(
        children: <Widget>[
          _animaisAdocao(context),
          _animaisPerdidos(context),
          _animaisRua(context),
          _itenDoacao(context),
        ],
      ),
    );
  }

  Widget _animaisAdocao(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('AnimalAdocao')
          .where('responsavel', isEqualTo: widget.dd['login'])
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: CircularProgressIndicator());
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  width: 400,
                                  height: 400,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black54, BlendMode.darken),
                                          image: NetworkImage(
                                              document['ftReference']),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PerfilAdocao(dd: document.data),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      document['nome'],
                                      style: textoPadraoBtn(context),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      AdocaoDAO ad = new AdocaoDAO();
                                      ad.deletarPub(document.documentID);
                                    }),
                              ),
                            ],
                          )),
                    ),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }

  Widget _animaisPerdidos(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('AnimalPerdido')
          .where('responsavel', isEqualTo: widget.dd['login'])
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: CircularProgressIndicator());
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  width: 400,
                                  height: 400,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black54, BlendMode.darken),
                                          image: NetworkImage(
                                              document['ftReference']),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetPerdido(dd: document.data),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      document['nome'],
                                      style: textoPadraoBtn(context),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        PerdidoDAO ad = new PerdidoDAO();
                                        ad.deletarPub(document.documentID);
                                      })),
                            ],
                          )),
                    ),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }

  Widget _animaisRua(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('AnimalAbandonado')
          .where('responsavel', isEqualTo: widget.dd['login'])
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: CircularProgressIndicator());
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  width: 400,
                                  height: 400,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black54, BlendMode.darken),
                                          image: NetworkImage(
                                              document['ftReference']),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetRua(dd: document.data),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      document['caracteristicas'],
                                      style: textoPadraoBtn(context),
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        AbandonadoDAO ad = new AbandonadoDAO();
                                        ad.deletarPub(document.documentID);
                                      })),
                            ],
                          )),
                    ),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }

  Widget _itenDoacao(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ItemDoacao')
          .where('responsavel', isEqualTo: widget.dd['login'])
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: CircularProgressIndicator());
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  width: 400,
                                  height: 400,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black54, BlendMode.darken),
                                          image: NetworkImage(
                                              document['ftReference']),
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
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        ItensDAO ad = new ItensDAO();
                                        ad.deletarPub(document.documentID);
                                      })),
                            ],
                          )),
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
