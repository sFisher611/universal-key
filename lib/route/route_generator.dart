// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:math_crud/pages/active_page.dart';
import 'package:math_crud/pages/edit_code_page.dart';
import 'package:math_crud/pages/error_api_info_page.dart';
import 'package:math_crud/pages/error_api_page.dart';
import 'package:math_crud/pages/error_app_page.dart';
import 'package:math_crud/pages/home_page.dart';
import 'package:math_crud/pages/main_page.dart';
import 'package:math_crud/pages/qr_scan_page.dart';
import 'package:math_crud/pages/security_page.dart';

import '../pages/error_app_info_page.dart';

class RouteGenerator {
  static const String home = '/home';
  static const String security = '/security';
  static const String main = '/main';
  static const String active = '/active';
  static const String editCode = '/editCode';
  static const String qrScan = '/qrScan';
  static const String errorApp = '/errorApp';
  static const String errorAppInfo = '/errorAppInfo';
  static const String errorAPI = '/errorApi';
  static const String errorApiInfo = '/errorApiInfo';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteGenerator.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteGenerator.security:
        return MaterialPageRoute(builder: (_) => const SecurityPage());
      case RouteGenerator.main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case RouteGenerator.active:
        return MaterialPageRoute(builder: (_) => const ActivePage());
      case RouteGenerator.qrScan:
        return MaterialPageRoute(builder: (_) => const QRScanPage());
      case RouteGenerator.errorApp:
        return MaterialPageRoute(builder: (_) => const ErrorAppPage());
      case RouteGenerator.errorAPI:
        return MaterialPageRoute(builder: (_) => const ErrorApiPage());
      case RouteGenerator.errorApiInfo:
        if (args != null) {
          return MaterialPageRoute(
              builder: (_) => ErrorApiInfoPage(
                    data: args,
                  ));
        }
        return _errorRoute();
      case RouteGenerator.errorAppInfo:
        if (args != null) {
          return MaterialPageRoute(
              builder: (_) => ErrorAppInfoPage(
                    data: args,
                  ));
        }
        return _errorRoute();
      case RouteGenerator.editCode:
        if (args != null) {
          return MaterialPageRoute(
              builder: (_) => EditCodePage(
                    data: args,
                  ));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Error data'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 100,
                  color: Colors.red.shade400,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Error!',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
