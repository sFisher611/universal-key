class PasswordPosition {
  PasswordPosition({
    this.text,
    this.active,
  });

  String text;
  bool active;

  factory PasswordPosition.fromJson(Map<String, dynamic> json) =>
      PasswordPosition(
        text: json["text"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "active": active,
      };
}
