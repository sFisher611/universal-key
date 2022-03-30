import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class HttpJson {
   sendPushMessage({String token, String body, String title}) async {
    try {
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAL-Oa7GE:APA91bGQ9BeOlnNgyEgS2dEVtF9SeddNcQNnCidfTPBJoIht4LEJCIw8dXhH7RSQh-W0uLb2aIyakvOnDdurko3RnOAP-YTSgF_KZTxG4o9AwJTmJcq34CiRCdrvirYoooOrKf4YjEs4',
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
        EasyLoading.showSuccess('Error:${res.statusCode}');
      }
    } catch (e) {
      EasyLoading.showInfo("Internet");
    }
  }
}
