import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:math_crud/models/code.dart';

class DataBase {
  FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection("test_base").orderBy('date').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Code code = Code.fromJson(doc);
          docs.add(code);
        }
      }
      return Future.value(docs);
    } catch (e) {
      print(e);
      return Future.error([]);
    }
  }

  Future<Code> searchCode(codeResult) async {
    QuerySnapshot querySnapshot;
    Code code;
    try {
      querySnapshot = await firestore
          .collection("test_base")
          .where('code', isEqualTo: codeResult)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          code = Code.fromJson(doc);
        }
      }
      return Future.value(code);
    } catch (e) {
      print(e);
      return Future.error(null);
    }
  }

  Future<List<Code>> readNotActive(isActive) async {
    QuerySnapshot querySnapshot;
    List<Code> docs = [];
    try {
      querySnapshot = await firestore
          .collection("test_base")
          .where('active', isEqualTo: isActive)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Code code = Code.fromJson(doc);
          docs.add(code);
        }
      }
      return Future.value(docs);
    } catch (e) {
      print(e);
      return Future.error([]);
    }
  }

  Future<bool> update(Code code) async {
    try {
      await firestore.collection("test_base").doc(code.id).update({
        'ip': code.ip,
        'name': code.name,
        'active': code.active,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await firestore.collection("test_base").doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> creat(Code code) async {
    Random random = Random();

    try {
      await firestore.collection("test_base").add({
        "name": code.name,
        "code": code.code,
        "date": FieldValue.serverTimestamp(),
        "ip": '192.168.${random.nextInt(100)}.${random.nextInt(100)}',
        "active": false,
        "admin": "BossAdmin",
        "token": "23523456234asf${random.nextInt(10000)}"
      });
    } catch (e) {
      print(e);
    }
  }
}
