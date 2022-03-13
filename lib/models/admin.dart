

class Admin {
  Admin({
    this.id,
    this.name,
    this.active,
    this.token,
  });

  String id;
  String name;
  String token;

  bool active;

  factory Admin.fromJson(var json) => Admin(
        id: json.id,
        name: json["name"],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "token": token,
      };
}
