import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helppet/controle/pessoa/usuario.dart';

class UsuarioDAO extends User {
  var db = Firestore.instance;
  var dd;
  bool x = false;

  Future<void> inserirUser(Map userComun) async {
    await db.collection('userComun').document(userComun['login']).setData({
      "nome": userComun['nome'],
      "login": userComun['login'],
      "senha": userComun['senha'],
      "email": userComun['email'],
    });
  }

  inserirUserFacebook(Map userComun) async {
    await db.collection('userComun').document(userComun['login']).setData(
      {
        "nome": userComun['nome'],
        "login": userComun['login'],
        "senha": userComun['login'],
        "email": userComun['email'],
      },
    );
    x = true;
    return x;
  }

  verificaExist(String login, String senha) async {
    QuerySnapshot pesq = await db
        .collection('userComun')
        .where('login', isEqualTo: login)
        .where('senha', isEqualTo: senha)
        .getDocuments();

    pesq.documents.forEach((d) {
      if (d.documentID != null) {
        x = true;
      } else {
        x = false;
      }
      userComun = d.data;
      dd = userComun;
    });
  }

  alterarSenha(login, nome, email, senha) async {
    await db.collection('userComun').document(login).setData({
      "nome": nome,
      "login": login,
      "senha": senha,
      "email": email,
    });
  }

  deletarPub(id) {
    db.collection('userComun').document(id).delete();
  }
}
