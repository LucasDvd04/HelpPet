import 'package:flutter/material.dart';
import 'package:helppet/model/UserDAO.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/view/Index.dart';
import 'package:latlong/latlong.dart';

class AltSenha extends StatefulWidget {
  final Map<String, dynamic> dd;
  AltSenha({Key key, @required this.dd}) : super(key: key);
  @override
  _AltSenhaState createState() => _AltSenhaState();
}

class _AltSenhaState extends State<AltSenha> {
  final Distance distance = new Distance();
  var x;
  TextEditingController senhaA = new TextEditingController();
  TextEditingController senhaN = new TextEditingController();
  TextEditingController senhaNC = new TextEditingController();
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
                                Icons.lock,
                                size: 100,
                              )),
                        ],
                      ),
                      TextFormField(
                        //entrade de senha
                        controller: senhaA,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: textoPadrao(context),
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Senha Atual',
                          labelText: 'Senha Atual',
                          labelStyle: textoPadrao(context),
                        ),
                      ),
                      TextFormField(
                        //entrade de senha
                        controller: senhaN,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: textoPadrao(context),
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Nova Senha',
                          labelText: 'Nova Senha',
                          labelStyle: textoPadrao(context),
                        ),
                      ),
                      TextFormField(
                        //entrade de senha
                        controller: senhaNC,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: textoPadrao(context),
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Cofirmação de Senha',
                          labelText: 'Nova Senha',
                          labelStyle: textoPadrao(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: _buildBtn(context),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void validadores() {
    if (senhaA.text.isEmpty) {
      _showMyDialog('senha atual');
    } else if (senhaN.text.isEmpty) {
      _showMyDialog('Senha nova');
    } else if (senhaNC.text.isEmpty) {
      _showMyDialog('confirmação');
    } else {
      if (senhaN.text == senhaNC.text) {
        altSenha();
      } else {
        _showErroC();
      }
    }
  }

  Future<void> altSenha() async {
    UsuarioDAO bank = new UsuarioDAO();

    await bank.verificaExist(widget.dd['login'], senhaA.text);

    if (bank.x == true) {
      bank.alterarSenha(widget.dd['login'], widget.dd['nome'],
          widget.dd['email'], senhaN.text);
      _showSucess();
    } else {
      _showErro();
    }
  }

  Future<void> _showMyDialog(campo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Campos'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('o campo $campo não foi preenchido'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Entendi!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSucess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exito'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Senha alterada com sucesso'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Entendi!'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Index(dd: widget.dd)));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErro() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Senha'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Senha incorreta'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Entendi!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErroC() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Senha'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Confirmação não é igual a nova senha'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Entendi!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
                    "Alterar",
                    style: textoPadraoBtn(context),
                  )
                ],
              ),
              onPressed: () {
                validadores();
              }),
        ),
      ),
    );
  }
}
