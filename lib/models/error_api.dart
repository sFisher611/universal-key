import 'package:intl/intl.dart';

class ErrorApi {
  ErrorApi({
    this.id,
    this.date,
    this.code,
    this.ip,
    this.name,
    this.error,
    this.check,
    this.params,
    this.response,
    this.url,
  });

  String date;
  String code;
  String ip;
  String id;
  String name;
  String error;
  String params;
  String response;
  String url;
  bool check;

  factory ErrorApi.fromJson(var json) => ErrorApi(
        date: DateFormat('dd.MM.yyyy – kk:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
                json["date"].millisecondsSinceEpoch)),
        code: json["code"],
        ip: json['ip'],
        id: json.id,
        name: json["name"],
        error: json['error'],
        response: json['response'],
        params: json['params'],
        url: json['url'],
        check: false,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "code": code,
        "ip": ip,
        "id": id,
        "name": name,
        "error": error,
        "response": response,
        "params": params,
        "url": url,
      };
}
