List<UniversalModel> provincesFromMap(List list) => List<UniversalModel>.from(
    list.map((x) => UniversalModel.fromJson(x)));



class UniversalModel {
  UniversalModel({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory UniversalModel.fromJson(var json) =>
      UniversalModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

}
