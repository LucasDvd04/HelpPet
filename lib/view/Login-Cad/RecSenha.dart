import 'package:flutter/material.dart';
import 'package:helppet/util/responsivo.dart';

class LostSenha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperação de senha'),
      ),
      body: PaginaLostSenha(),
    );
  }
}

class PaginaLostSenha extends StatefulWidget {
  @override
  _PaginaLostSenhaState createState() => _PaginaLostSenhaState();
}

class _PaginaLostSenhaState extends State<PaginaLostSenha> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    return Container(
        padding: EdgeInsets.only(
            top: size.height * 0.05, left: boxForm(), right: boxForm()),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Que pena, você esqueceu sua senha!'),
                Text('Nos vamos ajudar!'),
              ],
            ),
            TextFormField(
              //entrade de email
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: textoPadrao(),
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Por favor digite o seu e-mail',
                  labelText: 'E-mail',
                  labelStyle: textoPadrao()),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            _buildBtnEnviar(context)
          ],
        ));
  }

  Widget _buildBtnEnviar(BuildContext context) {
    //construtor do botão enviar
    return Container(
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
                  "ENVIAR",
                  style: textoPadraoBtn(context),
                )
              ],
            ),
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('E-mail enviado'),
                action: SnackBarAction(
                  label: 'Foi enviado um email de recuperação',
                  onPressed: () => {},
                ),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }),
      ),
    );
  }

  TextStyle textoPadrao() {
    //função responsavel por definir o tamanho da fonte de acordo com o tamanho da tela
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    var fontSize = size.width * 0.03;
    return TextStyle(
        fontSize: getValue(fontSize, 40, 12), fontWeight: FontWeight.bold);
  }

  double boxForm() {
    //função responsavel por definir o tamanho do container de informações de acordo com o tamanho da tela
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    var imgSize = size.width * 0.10;

    return imgSize;
  }
}
