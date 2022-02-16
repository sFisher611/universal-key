import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  late FirebaseFirestore firestore;
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
          Map a = {
            "id": doc.id,
            "name": doc['name'],
            "code": doc['code'],
            // "date": doc['date_time']
          };
          docs.add(a);
        }
      }
      return Future.value(docs);
    } catch (e) {
      print(e);
      return Future.error([]);
    }
  }

  Future<void> update(String id, String name, String code) async {
    try {
      await firestore
          .collection("test_base")
          .doc(id)
          .update({'name': name, 'code': code});
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("test_base").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> creat(name, code) async {
    try {
      await firestore.collection("test_base").add(
          {"name": name, "code": code, "date": FieldValue.serverTimestamp()});
    } catch (e) {
      print(e);
    }
  }
}
