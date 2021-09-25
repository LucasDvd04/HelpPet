import 'package:flutter/material.dart';
import 'package:helppet/model/UserDAO.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/view/Login-Cad/alterarSenha.dart';
import 'package:helppet/view/feeds/minhaPubs.dart';
import 'package:latlong/latlong.dart';

class Perfil extends StatefulWidget {
  final Map<String, dynamic> dd;
  Perfil({Key key, @required this.dd}) : super(key: key);
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final Distance distance = new Distance();
  var x;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu perfil'),
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
            padding: EdgeInsets.all(10),
            child: Container(
                width: getValue(size.width * 0.50, 900, 10),
                height: getValue(size.height * 0.70, 900, 0),
                decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(35)),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.person_pin,
                                size: 100,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Nome: ' + widget.dd['nome'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Indie-Flower"),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                widget.dd['email'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Indie-Flower"),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'login: ' + widget.dd['login'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Indie-Flower"),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AltSenha(dd: widget.dd)));
                                  },
                                  child: Text(
                                    'Alterar senha',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Indie-Flower"),
                                  ))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MinhasPubs(dd: widget.dd)));
                                  },
                                  child: Text(
                                    'Minhas publicações',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Indie-Flower"),
                                  ))),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          _buildBtn(context)
        ],
      ),
    );
  }

  Widget _buildBtn(BuildContext context) {
    //construtor do botão entrar
    return Center(
      child: Container(
        height: 50,
        width: 200,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffFFDBF7), Colors.lightBlueAccent],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SizedBox.expand(
          child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Excluir conta",
                    style: textoPadraoBtn(context),
                  )
                ],
              ),
              onPressed: () {
                UsuarioDAO ud = new UsuarioDAO();
                ud.deletarPub(widget.dd['login']);
              }),
        ),
      ),
    );
  }
}
