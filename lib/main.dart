import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

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
  });
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.security,
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: HomePage(),
      // home: SecurityPage(),
    );
  }
}
