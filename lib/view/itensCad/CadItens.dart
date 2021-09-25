// inicio Local onde ficam as impostações usadas
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helppet/controle/itens.dart';
import 'package:helppet/model/ItensDAO.dart';
import 'package:helppet/util/decoration.dart';
import 'package:helppet/util/location.dart';
import 'package:helppet/util/responsivo.dart';
import 'package:helppet/view/Index.dart';
import 'package:helppet/view/mapa/maps.dart';
import 'package:image_picker/image_picker.dart';
//fim Local onde ficam as impostações usadas

//Inicio de criação da status da tela
class CadItens extends StatefulWidget {
  final Map<String, dynamic> dd;
  CadItens({Key key, @required this.dd}) : super(key: key);
  @override
  _CadItensState createState() =>
      _CadItensState(); //função que cria o status toda vez que é alterada;

}
//fim  de criação da status da tela

enum RadioCategoria {
  alimentacao,
  higiene,
  utensilios,
  outros
} // valores do radio
RadioCategoria _categoria = RadioCategoria
    .alimentacao; //atribuição do valor padrão do radio(valor inicial)

class _CadItensState extends State<CadItens> {
  // A tela em si, que a ponta o status da pagina

  //variaveis de controle - manuteção de dados ou Gerencia de Status
  //variavei camera
  File im;
  PickedFile img;
  var imgName;
  PickedFile imgtemporaria;
  final _picker = ImagePicker();
//fim camera
  // instancias
  ItensDAO bank = new ItensDAO();
  Location l = new Location();
  Item it = new Item();
  //fim instancias

  //variaveis de cadastro
  var result;
  //fim variaveis de cadastro

  var tipo = 'alimento';
  bool alimentacao = true;
  bool higiene = true;
  bool utensilios = true;
  bool outros = true;
  final TextEditingController descricao = TextEditingController();
  final TextEditingController telefone = TextEditingController();
//Fim variaveis

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
          child: Center(
            child: _buildCad(context, size),
          )),
    );
  }
  // Fim Contrutor da tela(onde são iniciado tudo que vai aparecer na tela)

  //Contrutor do itens de cadastro

  Widget _buildCad(BuildContext context, Size size) {
    return Container(
      width: getValue(size.width * 0.90, 500, 10),
      height: getValue(size.height * 0.50, 400, 10),
      decoration: BoxDecoration(
          color: Colors.teal[50], borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: getValue(size.width * 0.15, 200, 10),
                    height: getValue(size.height * 0.05, 200, 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.lightGreen]),
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
                      gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.lightGreen]),
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
              //Incio Radios
              Column(children: <Widget>[
                // primeria coluna onde sera atribuido o radio
                Row(
                  //dentro da coluna é adiconado um linha onde contera outra coluna
                  mainAxisAlignment: MainAxisAlignment.center, //alinhamento
                  children: <Widget>[
                    Column(
                      //coluna onde contera o primeiro radio e o Texto
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              value: RadioCategoria
                                  .alimentacao, //valor atribuido ao icone de radio
                              groupValue: _categoria, // grupo do radio
                              onChanged: (RadioCategoria value) {
                                setState(() {
                                  tipo = 'alimento';
                                  //mudança de status
                                  alimentacao =
                                      true; //variavel para salvar o valor externamente
                                  _categoria =
                                      value; // valor que sera atribuido( mudara a selção do radio)
                                });
                              },
                            ),
                            Text('Alimentação'), //Texto presente na tela
                          ],
                        )
                      ],
                    ), //fim coluna onde contera o primeiro radio e o Texto
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              value: RadioCategoria.higiene,
                              groupValue: _categoria,
                              onChanged: (RadioCategoria value) {
                                setState(() {
                                  tipo = 'higiene';
                                  higiene = true;
                                  _categoria = value;
                                });
                              },
                            ),
                            Text('Higiene'),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              value: RadioCategoria.utensilios,
                              groupValue: _categoria,
                              onChanged: (RadioCategoria value) {
                                setState(() {
                                  tipo = 'utensilios';
                                  utensilios = true;
                                  _categoria = value;
                                });
                              },
                            ),
                            Text('Utensílios'),
                            Radio(
                              value: RadioCategoria.outros,
                              groupValue: _categoria,
                              onChanged: (RadioCategoria value) {
                                setState(() {
                                  tipo = 'outros';
                                  outros = true;
                                  _categoria = value;
                                });
                              },
                            ),
                            Text('Outros'),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  //entrada de texto Descrição
                  controller: descricao,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  style: textoPadrao(context),
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                    labelText: 'Descrição',
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
                Padding(
                    // espaçamente que o botão tera de todos os lados
                    padding: EdgeInsets.all(40),
                    child: _buildBtnCad(
                        context)) // inciando o botão dentro desse espaçamento,
              ])
            ],
          ),
        ),
      ),
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
                bank.inserirFotoDoacao(
                    im, widget.dd['login'] + imgName.toString());
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Outra foto'),
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
    if (descricao.text.isEmpty) {
      _showMyDialog('Descrição');
    } else if (result == null) {
      _showMyDialog('Local');
    } else if (im == null) {
      _showMyDialog('Foto');
    } else if (telefone.text.isEmpty) {
      _showMyDialog('Especie');
    } else {
      cads();
    }
  }

  cads() async {
    await bank.pegImage(widget.dd['login'] + imgName.toString());
    it.itensDoacao['tipo'] = tipo;
    it.itensDoacao['responsavel'] = widget.dd['login'];
    it.itensDoacao["nmResponsavel"] = widget.dd['nome'];
    it.itensDoacao['ftReference'] = bank.x.toString();
    it.itensDoacao['local'] = result;
    it.itensDoacao['descricao'] = descricao.text;
    it.itensDoacao['telContato'] = telefone.text;
    bank.inserirDoacao(it.itensDoacao);
    print(result);
  }
}
