import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:helppet/controle/itens.dart';

class ItensDAO extends Item {
  Firestore db = Firestore.instance;

  var x;

  inserirFotoDoacao(File img, nome) {
    StorageReference st =
        FirebaseStorage.instance.ref().child('ItemDoacao').child(nome);
    st.putFile(img);
  }

  void inserirDoacao(
    Map itensDoacao,
  ) {
    db.collection('ItemDoacao').document().setData({
      "responsavel": itensDoacao['responsavel'],
      "tipo": itensDoacao['tipo'],
      "ftReference": itensDoacao['ftReference'],
      "descricao": itensDoacao['descricao'],
      "local": itensDoacao['local'],
      "nmResponsavel": itensDoacao['nmResponsavel'],
      "telContato": itensDoacao['telContato'],
    });
  }

  pegImage(nome) async {
    final ref = await FirebaseStorage.instance
        .ref()
        .child('ItemDoacao')
        .child(nome)
        .getDownloadURL();
    x = ref.toString();
  }
   deletarPub(id) {
    db.collection('ItemDoacao').document(id).delete();
  }
}
