import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:helppet/controle/loging.dart';
import 'package:helppet/controle/pessoa/usuario.dart';
import 'package:helppet/model/UserDAO.dart';
import 'package:helppet/util/bubble_indication_painter.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/view/index.dart';

import 'RecSenha.dart';

class LoginCad extends StatefulWidget {
  // criando o status do widget
  @override
  _LoginCadState createState() => _LoginCadState(); //estanciando o mesmo
}

class _LoginCadState extends State<LoginCad> {
  final TextEditingController nome = TextEditingController();
  final TextEditingController login = TextEditingController();
  final TextEditingController senha = TextEditingController();
  final TextEditingController email = TextEditingController();

  UsuarioDAO bank = new UsuarioDAO();
  User us = new User();
  LoginFace lf = LoginFace();

  var local;
  bool confirm;
  var x = false;

  //status da pagina
  PageController
      _pageController; // estanciando a função PageController do MaterialApp

  //inicio das cores mais usadas
  Color left = Colors.black87;
  Color right = Colors.white;

  //fim das cores mais usadas

  // Inicio das Funções de Responsividade do aplicativo

  @override
  Widget build(BuildContext context) {
    // construtor principal do stf _PageState

    return Scaffold(
        body: _buildLogo(
            context)); // retornando o corpo da pagina definido em outro widget
  }

  @override
  void dispose() {
    //função para alterar o stado do MenuBar
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //função para alterar o stado do MenuBar
    super.initState();
    // l.checkPositionStream();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  Widget _buildLogo(BuildContext context) {
    // widget de logo e background
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Container(
      //Caixa
      padding: EdgeInsets.only(top: 15),
      decoration: buildDecoration(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: getValue(logoPadrao(context), 500, 10),
                  height: getValue(size.height * 0.23, 400, 10),
                  child: Image.asset('assets/img/logo.png')),
              _buildMenuBar(context), // iniciando o MenuBar
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (i) {
                    //alterando a cor do texto menu bar
                    if (i == 0) {
                      setState(() {
                        right = Colors.white;
                        left = Colors.black87;
                      });
                    } else if (i == 1) {
                      setState(() {
                        right = Colors.black87;
                        left = Colors.white;
                      });
                    }
                  },
                  children: <Widget>[
                    // carregando a pagina de acordo com a seleção do menu bar
                    new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: Container(
                          padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                          child: _buildLog(context), // widget de login
                        )),
                    new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Container(
                        padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                        child: _buildNovo(context),
                        //widget de cadastro
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    //menuBar
    return Container(
      width: 280,
      height: 30,
      decoration: BoxDecoration(
        color: rosa,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Entrar",
                  style: TextStyle(
                      color: left, fontSize: 15, fontFamily: "Indie-Flower"),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Cadastrar",
                  style: TextStyle(
                      color: right, fontSize: 15, fontFamily: "Indie-Flower"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLog(BuildContext context) {
    // construtor da tela de login
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    return Container(
        width: getValue(logoPadrao(context), 500, 10),
        height: getValue(size.height * 0.10, 400, 10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(35)),
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          //entrade de texto Login
                          controller: login,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          style: textoPadrao(context),
                          decoration: InputDecoration(
                              icon: Icon(Icons.account_box),
                              hintText: 'Digite o login',
                              labelText: 'Login',
                              labelStyle: textoPadrao(context)),
                        ),
                        TextFormField(
                          //entrada de texto senha
                          controller: senha,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          style: textoPadrao(context),
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            hintText: 'Digite a senha',
                            labelText: 'Senha',
                            labelStyle: textoPadrao(context),
                          ),
                        ),
                        Container(
                          //link de recuperação de senha
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            child: Text(
                              'Esqueci a senha',
                              textAlign: TextAlign.right,
                              style: textoPadraoLinks(context),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LostSenha()));
                            },
                          ),
                        ),
                        _buildBtnEntrar(context), //widget botão entrar
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Divider(color: Colors.blueGrey),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          height: getValue(size.height * 0.05, 600, 10),
                          alignment: Alignment.center,
                          child: FlatButton(
                            child: Text(
                              'Entrar com Facebook',
                              textAlign: TextAlign.center,
                              style: textoPadraoLinks(context),
                            ),
                            onPressed: () async {
                              var _x;
                              showProgress();
                              _x = await lf.tryLoginFacebook();
                              if (lf.x == true) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Index(dd: _x)));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildBtnEntrar(BuildContext context) {
    //construtor do botão entrar
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
                  "ENTRAR",
                  style: textoPadraoBtn(context),
                )
              ],
            ),
            onPressed: () {
              acept();
            }),
      ),
    );
  }

  Widget _buildNovo(BuildContext context) {
    //construtor da tela de cadastro
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    return Container(
      child: Container(
          width: getValue(size.width * 0.20, 500, 10),
          height: getValue(size.height * 0.02, 400, 0),
          child: Scrollbar(
            child: ListView(
              children: <Widget>[
                Container(
                    width: getValue(size.width * 0.50, 900, 10),
                    height: getValue(size.height * 0.62, 900, 0),
                    decoration: BoxDecoration(
                        color: Colors.teal[50],
                        borderRadius: BorderRadius.circular(35)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: getValue(size.height * 0.05, 100, 2),
                          left: getValue(size.height * 0.05, 100, 2),
                          right: getValue(size.height * 0.08, 100, 2),
                          bottom: getValue(size.height * 0.02, 100, 2)),
                      child: SizedBox(
                        child: ListView(
                          children: <Widget>[
                            TextFormField(
                              //entrada nome
                              controller: nome,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                              style: textoPadrao(context),
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Digite o seu nome',
                                  labelText: 'Nome',
                                  labelStyle: textoPadrao(context)),
                            ),
                            TextFormField(
                              //entrada de login
                              controller: login,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                              style: textoPadrao(context),
                              decoration: InputDecoration(
                                  icon: Icon(Icons.account_box),
                                  hintText: 'Digite o login',
                                  labelText: 'Login',
                                  labelStyle: textoPadrao(context)),
                            ),
                            TextFormField(
                              //entrade de senha
                              controller: senha,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              textAlign: TextAlign.center,
                              style: textoPadrao(context),
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: 'Digite uma senha',
                                labelText: 'Senha',
                                labelStyle: textoPadrao(context),
                              ),
                            ),
                            TextFormField(
                              //entrade de email
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              style: textoPadrao(context),
                              decoration: InputDecoration(
                                  icon: Icon(Icons.email),
                                  hintText: 'Digite o seu e-mail',
                                  labelText: 'E-mail',
                                  labelStyle: textoPadrao(context)),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            _buildBtnCad(context), //widget botão cadastrar
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  Widget _buildBtnCad(BuildContext context) {
    //construtor do botão de cadastro
    return Container(
      height: 40,
      width: 150,
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
                  "CADASTRAR",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onPressed: () {
              validadores();
            }),
      ),
    );
  }

  _onSignInButtonPress() {
    //Animação do botão entrar
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  _onSignUpButtonPress() {
    //Animação do botão cadastrar
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void validadores() {
    if (nome.text.isEmpty) {
      _showMyDialog('Nome');
    } else if (login.text.isEmpty) {
      _showMyDialog('Login');
    } else if (senha.text.isEmpty) {
      _showMyDialog('Senha');
    } else if (email.text.isEmpty) {
      _showMyDialog('Email');
    } else {
      addUser();
    }
  }

  Future<void> addUser() async {
    await bank.verificaExist(login.text, senha.text);
    if (bank.x == false) {
      cads();
      bank.inserirUser(us.userComun);
      _showMySucess();
    } else {
      _showExist();
    }
  }

  void acept() async {
    if (login.text.isEmpty) {
      _showMyDialog('Login');
    } else if (senha.text.isEmpty) {
      _showMyDialog('Senha');
    } else {
      await bank.verificaExist(login.text, senha.text);
      confirm = bank.x;
      switch (confirm) {
        case true:
          {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Index(dd: bank.dd)));
          }
          break;
        case false:
          {
            _showLogin();
          }
          break;
      }
    }
  }

  Future<void> _showMyDialog(campo) {
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

  Future<void> showProgress() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
              value: 500,
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMySucess() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cadastrado!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Cadastrado com sucesso!'),
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

  Future<void> _showLogin() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Login ou senha incorrento'),
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

  Future<void> _showExist() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('O usuario já existe'),
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

  void cads() {
    us.userComun['nome'] = nome.text;
    us.userComun['login'] = login.text;
    us.userComun['senha'] = senha.text;
    us.userComun['email'] = email.text;
  }
}
