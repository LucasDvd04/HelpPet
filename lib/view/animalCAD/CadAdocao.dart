import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helppet/controle/animal/animal.dart';
import 'package:helppet/model/AnimalDAO.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/location.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/view/Index.dart';
import 'package:helppet/view/mapa/maps.dart';
import 'package:image_picker/image_picker.dart';

class CadAdocao extends StatefulWidget {
  final Map<String, dynamic> dd;
  CadAdocao({Key key, @required this.dd}) : super(key: key);
  @override
  _CadAdocaoState createState() => _CadAdocaoState();
}

enum RadioVacina { vacinado, nvacinado }
RadioVacina _vacina = RadioVacina.vacinado;
enum RadioGenero { macho, femea }
RadioGenero _sexo = RadioGenero.macho;
enum RadioCast { castrado, ncastrado }
RadioCast _cast = RadioCast.castrado;

class _CadAdocaoState extends State<CadAdocao> {
  // camera
  File im;
  PickedFile img;
  PickedFile imgtemporaria;
  var imgName;
  final _picker = ImagePicker();
  //fim camera

  // instancias
  AdocaoDAO bank = new AdocaoDAO();
  Location l = new Location();
  Animal ad = Animal();
  //fim instancias

  //variaveis de castro
  var sexo = 'macho';
  var especie;

  bool vacina = true;
  bool cast = true;
  final TextEditingController nome = TextEditingController();
  final TextEditingController idade = TextEditingController();
  final TextEditingController raca = TextEditingController();
  final TextEditingController telefone = TextEditingController();
  var result;
  //fim variaveis de cadastro

  //vaiaveis/funçoes de animação
  bool _animationCat = true;
  bool _animationDog = true;
  void _animationGato() {
    setState(() {
      _animationCat = _animationCat ? false : true;
    });
  }

  void _animationCachorro() {
    setState(() {
      _animationDog = _animationDog ? false : true;
    });
  }
  //fim vaiaveis/funçoes de animação

  @override
  Widget build(BuildContext context) {
    l.checkPositionStream();
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Adoção'),
        backgroundColor: azul,
      ),
      body: Container(
          decoration: buildDecoration(),
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Center(
                    child: Text(
                      'Selecione a especie',
                      style: TextStyle(
                          fontFamily: "Indie-Flower",
                          fontSize: size.width * 0.08),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _selecGato(context),
                    _selecCao(context, size)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: _buildCad(context, size),
                )
              ],
            ),
          )),
    );
  }

  Widget _selecGato(BuildContext context) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      crossFadeState:
          _animationCat ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        width: getValue(widtchIndexOp(context) * 0.25, 500, 10),
        height: getValue(heigthIndexOp(context) * 0.10, 500, 10),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage('assets/img/gato.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: FlatButton(
          onPressed: () {
            if (_animationDog == false) {
              _animationCachorro();
            }
            especie = "G";
            _animationGato();
          },
          child: null,
        ),
      ),
      secondChild: Container(
        width: getValue(widtchIndexOp(context) * 0.25, 500, 10),
        height: getValue(heigthIndexOp(context) * 0.12, 500, 10),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage('assets/img/gato.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Container(
          width: 2,
          height: 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: SizedBox.expand(
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _selecCao(BuildContext context, Size size) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      crossFadeState:
          _animationDog ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        width: getValue(widtchIndexOp(context) * 0.25, 500, 10),
        height: getValue(heigthIndexOp(context) * 0.10, 500, 10),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage('assets/img/cachorro.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: FlatButton(
          child: null,
          onPressed: () {
            if (_animationCat == false) {
              _animationGato();
            }
            especie = 'C';
            _animationCachorro();
          },
        ),
      ),
      secondChild: Container(
        width: getValue(widtchIndexOp(context) * 0.25, 500, 10),
        height: getValue(heigthIndexOp(context) * 0.12, 500, 10),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage('assets/img/cachorro.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Container(
          width: 2,
          height: 2,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: SizedBox.expand(
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCad(BuildContext context, Size size) {
    return Container(
        width: getValue(size.width * 0.80, 500, 10),
        height: getValue(size.height * 0.70, 900, 10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 40, bottom: 10),
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: getValue(size.width * 0.15, 200, 10),
                              height: getValue(size.height * 0.05, 200, 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.greenAccent,
                                  Colors.lightGreen
                                ]),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                  onPressed: () {
                                    showMyFt(context);
                                  },
                                  child: Icon(
                                    Icons.camera_enhance,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: getValue(size.width * 0.15, 200, 10),
                              height: getValue(size.height * 0.05, 200, 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.greenAccent,
                                  Colors.lightGreen
                                ]),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                  onPressed: () async {
                                    result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Mapa(
                                          lat: l.lat,
                                          long: l.long,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.pin_drop,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          //entrada de texto nome
                          controller: nome,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          style: textoPadrao(context),
                          decoration: InputDecoration(
                            hintText: 'Nome do animal',
                            labelText: 'Nome',
                            labelStyle: textoPadrao(context),
                          ),
                        ),
                        TextFormField(
                          //entrade de texto Raça
                          controller: raca,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          style: textoPadrao(context),
                          decoration: InputDecoration(
                              hintText: 'Raça do animal',
                              labelText: 'Raça',
                              labelStyle: textoPadrao(context)),
                        ),
                        TextFormField(
                          //entrade de texto idade
                          controller: idade,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: textoPadrao(context),
                          decoration: InputDecoration(
                            hintText: 'Idade do animal',
                            labelText: 'Idade',
                            labelStyle: textoPadrao(context),
                          ),
                        ),
                        TextFormField(
                          //entrada de texto Telefone
                          controller: telefone,
                          keyboardType: TextInputType.phone,

                          textAlign: TextAlign.center,
                          style: textoPadrao(context),
                          decoration: InputDecoration(
                            hintText: 'Telefone',
                            labelText: 'Telefone Para Contato',
                            labelStyle: textoPadrao(context),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Sexo:'),
                                        Radio(
                                          value: RadioGenero.macho,
                                          groupValue: _sexo,
                                          onChanged: (RadioGenero value) {
                                            setState(() {
                                              sexo = 'macho';
                                              _sexo = value;
                                            });
                                          },
                                        ),
                                        Text('Macho'),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          value: RadioGenero.femea,
                                          groupValue: _sexo,
                                          onChanged: (RadioGenero value) {
                                            setState(() {
                                              sexo = 'femea';
                                              _sexo = value;
                                            });
                                          },
                                        ),
                                        Text('Femea'),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Vacinado:'),
                                        Radio(
                                          value: RadioVacina.vacinado,
                                          groupValue: _vacina,
                                          onChanged: (RadioVacina value) {
                                            setState(() {
                                              vacina = true;
                                              _vacina = value;
                                            });
                                          },
                                        ),
                                        Text('Sim'),
                                        Radio(
                                          value: RadioVacina.nvacinado,
                                          groupValue: _vacina,
                                          onChanged: (RadioVacina value) {
                                            setState(() {
                                              vacina = false;
                                              _vacina = value;
                                            });
                                          },
                                        ),
                                        Text('Não'),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Castrado:'),
                                        Radio(
                                          value: RadioCast.castrado,
                                          groupValue: _cast,
                                          onChanged: (RadioCast value) {
                                            setState(() {
                                              cast = true;
                                              _cast = value;
                                            });
                                          },
                                        ),
                                        Text('Sim'),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          value: RadioCast.ncastrado,
                                          groupValue: _cast,
                                          onChanged: (RadioCast value) {
                                            setState(() {
                                              cast = false;
                                              _cast = value;
                                            });
                                          },
                                        ),
                                        Text('Não'),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        _buildBtnCad(context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
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
            _showMySucess();
          },
        ),
      ),
    );
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

  Future<void> _showMySucess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cadastrado!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Animal Cadastrado com sucesso!'),
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

  Future<void> showMyFt(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _fotoCamera();
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.blue,
                  size: 50,
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _fotoGaleria();
                },
                child: Icon(
                  Icons.image,
                  color: Colors.green,
                  size: 50,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMyFoto(context, img) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Image.file(im),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceitar!'),
              onPressed: () async {
                imgName = await im.lastModified();
                bank.inserirFotoAnimalAdocao(
                    im, widget.dd['login'] + imgName.toString());
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Outra foto'),
              onPressed: () {
                im = null;
                img = null;
                Navigator.of(context).pop();
                showMyFt(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showError(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(child: Text('Nenhuma foto')),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Tentar novamente'),
              onPressed: () {
                Navigator.of(context).pop();
                showMyFt(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future _fotoGaleria() async {
    imgtemporaria = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 8,
      maxWidth: 650,
      maxHeight: 650,
    );

    if (imgtemporaria != null) {
      setState(() {
        img = imgtemporaria;
        im = File(img.path);
      });
    }

    im != null ? _showMyFoto(context, im) : _showError(context);
  }

  Future _fotoCamera() async {
    imgtemporaria = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 5,
        maxWidth: 650,
        maxHeight: 650);

    if (imgtemporaria != null) {
      setState(() {
        img = imgtemporaria;
        im = File(img.path);
      });
    }

    im != null ? _showMyFoto(context, im) : _showError(context);
  }

  void validadores() {
    if (nome.text.isEmpty) {
      _showMyDialog('Nome');
    } else if (raca.text.isEmpty) {
      _showMyDialog('Raca');
    } else if (idade.text.isEmpty) {
      _showMyDialog('Idade');
    } else if (especie == null) {
      _showMyDialog('Especie');
    } else if (telefone.text.isEmpty) {
      _showMyDialog('Telefone');
    } else if (result == null) {
      _showMyDialog('Local');
    } else if (im == null) {
      _showMyDialog('Foto');
    } else
      cads();
  }

  cads() async {
    await bank.pegImage(widget.dd['login'] + imgName.toString());
    ad.animalDoacao["nome"] = nome.text;
    ad.animalDoacao["especie"] = especie;
    ad.animalDoacao["raca"] = raca.text;
    ad.animalDoacao["idade"] = idade.text;
    ad.animalDoacao["sexo"] = sexo;
    ad.animalDoacao["vacina"] = vacina;
    ad.animalDoacao["castracoes"] = cast;
    ad.animalDoacao["responsavel"] = widget.dd['login'];
    ad.animalDoacao["nmResponsavel"] = widget.dd['nome'];
    ad.animalDoacao['local'] = result;
    ad.animalDoacao['ftReference'] = bank.x.toString();
    ad.animalDoacao['telContato'] = telefone.text;

    bank.inserirAdocao(ad.animalDoacao);
  }
}
