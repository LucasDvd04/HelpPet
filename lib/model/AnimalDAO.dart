import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:helppet/controle/animal/animal.dart';

class AdocaoDAO extends Animal {
  Firestore db = Firestore.instance;

  var x;

  inserirFotoAnimalAdocao(File img, nome) {
    StorageReference st = FirebaseStorage.instance
        .ref()
        .child('Animais')
        .child('AnimalAdocao')
        .child(nome);
    st.putFile(img);
  }

  void inserirAdocao(
    Map animal,
  ) {
    db.collection('AnimalAdocao').add({
      "responsavel": animal['responsavel'],
      "nmResponsavel": animal['nmResponsavel'],
      "telContato": animal['telContato'],
      "nome": animal['nome'],
      "especie": animal['especie'],
      "raca": animal['raca'],
      "idade": animal['idade'],
      "sexo": animal['sexo'],
      "vacina": animal['vacina'],
      "castracoes": animal['castracoes'],
      'ftReference': animal['ftReference'],
      'local': animal['local'],
    });
  }

  pegImage(nome) async {
    final ref = await FirebaseStorage.instance
        .ref()
        .child('Animais')
        .child('AnimalAdocao')
        .child(nome)
        .getDownloadURL();
    x = ref.toString();
  }

  deletarPub(id) {
    db.collection('AnimalAdocao').document(id).delete();
  }
}

class PerdidoDAO extends Animal {
  var db = Firestore.instance;
  var x;

  void inserirPerdido(Map animal) {
    db.collection('AnimalPerdido').add({
      "responsavel": animal['responsavel'],
      "nmResponsavel": animal['nmResponsavel'],
      "nome": animal['nome'],
      "especie": animal['especie'],
      "local": animal['local'],
      "sexo": animal['sexo'],
      "caracteristicas": animal['caracteristicas'],
      "telContato": animal['telContato'],
      'ftReference': animal['ftReference'],
    });
  }

  inserirFotoAnimalPerdido(File img, nome) {
    StorageReference st = FirebaseStorage.instance
        .ref()
        .child('Animais')
        .child('AnimalPerdido')
        .child(nome);
    st.putFile(img);
  }

  pegImage(nome) async {
    final ref = await FirebaseStorage.instance
        .ref()
        .child('Animais')
        .child('AnimalPerdido')
        .child(nome)
        .getDownloadURL();
    x = ref.toString();
  }

  deletarPub(id) {
    db.collection('AnimalPerdido').document(id).delete();
  }
}

class AbandonadoDAO extends Animal {
  var db = Firestore.instance;
  var x;

  void inserirAbandonado(Map animal) {
    db.collection('AnimalAbandonado').add({
      "raca": animal["raca"],
      "responsavel": animal['responsavel'],
      "nmResponsavel": animal['nmResponsavel'],
      "especie": animal['especie'],
      "local": animal['local'],
      "caracteristicas": animal['caracteristicas'],
      'ftReference': animal['ftReference'],
    });
  }

  inserirFotoAnimalAbandonado(File img, nome) {
    StorageReference st = FirebaseStorage.instance
        .ref()
        .child('Animais')
        .child('AnimalAbandonado')
        .child(nome);
    st.putFile(img);
  }

  pegImage(nome) async {
    final ref = await FirebaseStorage.instance
        .ref()
        .child('Animais')
        .child('AnimalAbandonado')
        .child(nome)
        .getDownloadURL();
    x = ref.toString();
  }

  pegsImage(nome) async {
    final ref = await FirebaseStorage.instance
        .ref()
        .child('Animais')
        .child('AnimalAbandonado')
        .getDownloadURL();
    x = ref.toString();
  }

  deletarPub(id) {
    db.collection('AnimalAbandonado').document(id).delete();
  }
}
