import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:math_crud/db/database.dart';
import 'package:math_crud/models/admin.dart';

import 'route/route_generator.dart';
import 'service/toast_service.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await init();
  runApp(const MyApp());
  configLoading();
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getToken();
}

void getToken() async {
  await FirebaseMessaging.instance.getToken().then((token) async {
    Box box = await Hive.openBox('db');
    await box.put('token', token);
    loadingAdminUser(token);
  });
}

loadingAdminUser(token) async {
  if (token != null) {
    DataBase db = DataBase();
    Admin admin = Admin(name: 'user', token: token);
    await db.initiliase();
    db.searchAdmin(token).then((Admin adminResult) {
      if (adminResult == null) {
        db.creatAdmin(admin);
      }
    });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.security,
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: HomePage(),
      // home: SecurityPage(),
    );
  }
}
