import 'package:intl/intl.dart';

class ErrorApp {
  ErrorApp({
    this.id,
    this.date,
    this.code,
    this.ip,
    this.name,
    this.error,
    this.check,
  });

  String date;
  String code;
  String ip;
  String id;
  String name;
  String error;
  bool check;

  factory ErrorApp.fromJson(var json) => ErrorApp(
        date: DateFormat('dd.MM.yyyy – kk:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
                json["date"].millisecondsSinceEpoch)),
        code: json["code"],
        ip: json['ip'],
        id: json.id,
        name: json["name"],
        error: json['error'],
        check: false,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "code": code,
        "ip": ip,
        "id": id,
        "name": name,
        "error": error,
      };
}
