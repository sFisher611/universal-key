import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:math_crud/models/code.dart';
import 'package:math_crud/models/error_api.dart';
import 'package:math_crud/models/error_app.dart';
import 'package:math_crud/models/universal.dart';

import '../models/admin.dart';

class DataBase {
  FirebaseFirestore firestore;
  initializes() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection("pay_user").orderBy('date').get();
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
          .collection("pay_user")
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
    var a;
    try {
      querySnapshot = await firestore
          .collection("pay_user")
          .where('active', isEqualTo: isActive)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          a = doc;
          if(a["code"]=="483072468"){
            print("object");
          }
          Code code = Code.fromJson(doc);
          docs.add(code);
        }
      }
      return Future.value(docs);
    } catch (e) {
      print(a['code']);
      print(e);
      return Future.error([]);
    }
  }

  Future<bool> update(Code code) async {
    try {
      await firestore.collection("pay_user").doc(code.id).update({
        'ip': code.ip,
        'name': code.name,
        'active': code.active,
        "branch_id": code.branchId,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await firestore.collection("pay_user").doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> create(Code code) async {
    Random random = Random();

    try {
      await firestore.collection("pay_user").add({
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

  //admin
  Future<void> createAdmin(Admin admin) async {
    try {
      await firestore.collection("admin_user").add({
        "name": admin.name,
        "active": false,
        "token": admin.token,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Admin> searchAdmin(adminToken) async {
    QuerySnapshot querySnapshot;
    Admin admin;
    try {
      querySnapshot = await firestore
          .collection("admin_user")
          .where('token', isEqualTo: adminToken)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          admin = Admin.fromJson(doc);
        }
      }
      return Future.value(admin);
    } catch (e) {
      print(e);
      return Future.error(null);
    }
  }

  Future<void> onCreateBranch(id, branch) async {
    try {
      await firestore.collection("branchs").add({
        "id": id,
        "name": branch,
        "centre_id": "",
      });
    } catch (_) {}
  }

  Future<List<UniversalModel>> readBranch() async {
    QuerySnapshot querySnapshot;
    List<UniversalModel> docs = [];
    try {
      querySnapshot = await firestore.collection("branchs").get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          UniversalModel universalModel = UniversalModel.fromJson(doc);
          docs.add(universalModel);
        }
      }
      return Future.value(docs);
    } catch (e) {
      print(e);
      return Future.error([]);
    }
  }

  Future<List<ErrorApp>> readErrorApp() async {
    QuerySnapshot querySnapshot;
    List<ErrorApp> docs = [];
    try {
      querySnapshot =
          await firestore.collection("error_app").orderBy('date').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          ErrorApp error = ErrorApp.fromJson(doc);
          docs.add(error);
        }
      }
      return Future.value(docs);
    } catch (e) {
      print(e);
      return Future.error([]);
    }
  }

  Future<bool> deleteErrorApp(String id) async {
    try {
      await firestore.collection("error_app").doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ErrorApi>> readErrorApi() async {
    QuerySnapshot querySnapshot;
    List<ErrorApi> docs = [];
    try {
      querySnapshot = await firestore.collection("error_backend").get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          ErrorApi error = ErrorApi.fromJson(doc);
          docs.add(error);
        }
      }
      return Future.value(docs);
    } catch (e) {
      print(e);
      return Future.error([]);
    }
  }

  Future<ErrorApi> readErrorApiID(errorId) async {
    QuerySnapshot querySnapshot;
    ErrorApi error;
    try {
      querySnapshot = await firestore
          .collection("error_backend")
          .where(FieldPath.documentId, isEqualTo: errorId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          error = ErrorApi.fromJson(doc);
        }
      }
      return Future.value(error);
    } catch (e) {
      print(e);
      return Future.error(null);
    }
  }

  Future<bool> deleteErrorApi(String id) async {
    try {
      await firestore.collection("error_backend").doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
