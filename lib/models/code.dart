import 'package:intl/intl.dart';

class Code {
  Code({
    this.date,
    this.code,
    this.ip,
    this.id,
    this.name,
    this.active,
    this.admin,
    this.token,
  });

  String date;
  String code;
  String ip;
  String id;
  String name;
  String token;
  String admin;
  bool active;

  factory Code.fromJson(var json) => Code(
        date: DateFormat('dd.MM.yyyy – kk:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
                json["date"].millisecondsSinceEpoch)),
        code: json["code"],
        ip: json['ip'],
        id: json.id,
        name: json["name"],
        active: json["active"],
        admin: json['admin'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "code": code,
        "ip": ip,
        "id": id,
        "name": name,
        "active": active,
        "admin": admin,
        "token": token,
      };
}
