import 'package:flutter/material.dart';
import 'package:helppet/model/UserDAO.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/view/Login-Cad/LoginCadastro.dart';
import 'package:helppet/view/feeds/adocoes/gato.dart';
import 'package:helppet/view/feeds/perdidos.dart';
import 'package:helppet/view/feeds/rua.dart';
import 'package:helppet/view/informacoes/denuncia.dart';
import 'package:helppet/view/informacoes/perfil.dart';
import 'package:helppet/view/itensCad/CadItens.dart';
import 'animalCAD/CadAbandonado.dart';
import 'animalCAD/CadAdocao.dart';
import 'animalCAD/CadPerdido.dart';
import 'feeds/adocoes/cao.dart';
import 'feeds/doacoes.dart';

class Index extends StatefulWidget {
  final Map<String, dynamic> dd;
  Index({Key key, @required this.dd}) : super(key: key);
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  UsuarioDAO us = new UsuarioDAO();
  bool _animationAdt = true;
  bool _animationDoac = true;
  bool _animationPerd = true;
  bool _animationRua = true;

  void _animatioAdotar() {
    setState(() {
      _animationAdt = _animationAdt ? false : true;
    });
  }

  void _animatioDoacao() {
    setState(() {
      _animationDoac = _animationDoac ? false : true;
    });
  }

  void _animatioPerdidos() {
    setState(() {
      _animationPerd = _animationPerd ? false : true;
    });
  }

  void _animatioRua() {
    setState(() {
      _animationRua = _animationRua ? false : true;
    });
  }

  Color azul = Color(0xff87CEFA);
  Color rosa = Color(0xffFFE4E1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: azul,
      ),
      drawer: _buildDrawer(),
      body: Container(
          decoration: buildDecoration(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  _buildAdotar(context),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildDoacoes(context),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildPerdidos(context),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _buildRua(context),
                ],
              ),
            ),
          )),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Center(
                child: ListTile(
                  title: Text(
                    widget.dd['nome'],
                    style: TextStyle(
                        fontSize:
                            getValue(widtchIndexOp(context) * 0.07, 100, 10)),
                  ),
                  subtitle: Text(widget.dd['email']),
                ),
              ),
              decoration: buildDecoration()),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('Meu perfil'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Perfil(dd: widget.dd)));
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginCad()));
            },
          ),
          Divider(
            color: Colors.blue,
          ),
          ListTile(
            leading: Icon(Icons.more),
            title: Text('Maus tratos?'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Denuncia()));
            },
          ),
          Divider(
            color: Colors.blue,
          ),
          Center(child: Text('Propaganda')),
          Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                child: Center(child: Image.asset('assets/img/abandonado.jpg')),
              ))
        ],
      ),
    );
  }

  Widget _buildAdotar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              crossFadeState: _animationAdt
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                width: getValue(widtchIndexOp(context) * 0.85, 500, 10),
                height: getValue(heigthIndexOp(context) * 0.19, 500, 10),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black26, BlendMode.darken),
                    image: AssetImage('assets/img/logo.png'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  onPressed: () {
                    if (_animationDoac == false) {
                      _animatioDoacao();
                    }
                    if (_animationPerd == false) {
                      _animatioPerdidos();
                    }
                    if (_animationRua == false) {
                      _animatioRua();
                    }
                    _animatioAdotar();
                  },
                  child: Text(
                    'Adoções',
                    style: textoPadraoBtn(context),
                  ),
                  textColor: Colors.white,
                ),
              ),
              secondChild: Container(
                width: getValue(widtchIndexOp(context) * 0.85, 500, 10),
                height: getValue(heigthIndexOp(context) * 0.25, 500, 10),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.darken),
                    image: AssetImage('assets/img/catDog.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GatosDiponiveis(),
                            ),
                          ),
                        },
                        child: Text(
                          'Gato',
                          style: textoPadraoBtn(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CadAdocao(
                                        dd: widget.dd,
                                      )));
                        },
                        child: Text(
                          'Cadastrar',
                          style: textoPadraoBtn(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CaesDiponiveis()))
                        },
                        child: Text(
                          'Cachorro',
                          style: textoPadraoBtn(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDoacoes(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              crossFadeState: _animationDoac
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                width: getValue(widtchIndexOp(context) * 0.85, 500, 10),
                height: getValue(heigthIndexOp(context) * 0.19, 500, 10),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black26, BlendMode.darken),
                    image: AssetImage('assets/img/doacoes.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  onPressed: () {
                    if (_animationAdt == false) {
                      _animatioAdotar();
                    }
                    if (_animationPerd == false) {
                      _animatioPerdidos();
                    }
                    if (_animationRua == false) {
                      _animatioRua();
                    }
                    _animatioDoacao();
                  },
                  child: Text(
                    'Doações',
                    style: textoPadraoBtn(context),
                  ),
                  textColor: Colors.white,
                ),
              ),
              secondChild: Container(
                width: getValue(widtchIndexOp(context) * 0.85, 500, 10),
                height: getValue(heigthIndexOp(context) * 0.25, 500, 10),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.darken),
                    image: AssetImage('assets/img/doacoes.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoacoesDiponiveis()))
                        },
                        child: Text(
                          'Disponiveis',
                          style: textoPadraoBtn(context),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CadItens(dd: widget.dd),
                            ),
                          ),
                        },
                        child: Text(
                          'Doar',
                          style: textoPadraoBtn(context),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerdidos(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              crossFadeState: _animationPerd
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                width: getValue(widtchIndexOp(context) * 0.85, 500, 10),
                height: getValue(heigthIndexOp(context) * 0.19, 500, 10),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black26, BlendMode.darken),
                    image: AssetImage('assets/img/perdidos.png'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  onPressed: () {
                    if (_animationAdt == false) {
                      _animatioAdotar();
                    }
                    if (_animationDoac == false) {
                      _animatioDoacao();
                    }
                    if (_animationRua == false) {
                      _animatioRua();
                    }
                    _animatioPerdidos();
                  },
                  child: Text(
                    'Perdidos',
                    style: textoPadraoBtn(context),
                  ),
                  textColor: Colors.white,
                ),
              ),
              secondChild: Container(
                width: getValue(widtchIndexOp(context) * 0.85, 500, 10),
                height: getValue(heigthIndexOp(context) * 0.25, 500, 10),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.darken),
                    image: AssetImage('assets/img/perdidos.png'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnimaisPerdidos()))
                        },
                        child: Text(
                          'Animais Desaparecidos',
                          style: textoPadraoBtn(context),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CadPerdido(
                                        dd: widget.dd,
                                      )));
                        },
                        child: Text(
                          'Cadastrar',
                          style: textoPadraoBtn(context),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRua(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              crossFadeState: _animationRua
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                width: getValue(widtchIndexOp(context) * 0.85, 500, 10),
                height: getValue(heigthIndexOp(context) * 0.19, 500, 10),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black26, BlendMode.darken),
                    image: AssetImage('assets/img/abandonado.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  onPressed: () {
                    if (_animationAdt == false) {
                      _animatioAdotar();
                    }
                    if (_animationDoac == false) {
                      _animatioDoacao();
                    }
                    if (_animationPerd == false) {
                      _animatioPerdidos();
                    }
                    _animatioRua();
                  },
                  child: Text(
                    'Abandonados',
                    style: textoPadraoBtn(context),
                  ),
                  textColor: Colors.white,
                ),
              ),
              secondChild: Container(
                width: getValue(widtchIndexOp(context) * 0.85, 500, 10),
                height: getValue(heigthIndexOp(context) * 0.25, 500, 10),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.darken),
                    image: AssetImage('assets/img/abandonado.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnimaisRua()))
                        },
                        child: Text(
                          'Resgatar',
                          style: textoPadraoBtn(context),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CadAbandonado(dd: widget.dd)));
                        },
                        child: Text(
                          'Cadastrar',
                          style: textoPadraoBtn(context),
                        ),
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
