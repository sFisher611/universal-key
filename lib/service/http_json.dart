import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class HttpJson {
  void sendPushMessage({String token, String body, String title}) async {
    try {
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA0zDbST0:APA91bFD-JZJHpX9B7QQBpB9IHei3ACMtoZWwFj7XhFqF-DwJd1FTC8fmCQEMhnsge-ys1fYpPytTP2yoFJGeNF24tUMz-YMHdXy0WMsmw1SG2XkUQvJAhQHnuS-A9KDByk2n3KU6KOR',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Success:${res.statusCode}');
      } else {
        EasyLoading.showError('Error:${res.statusCode}');
      }
    } catch (e) {
      EasyLoading.showInfo("Internet");
    }
  }
}
