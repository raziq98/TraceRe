class WorkTypeResponse {
  int? itemCount;
  List<WorkType>? list;

  WorkTypeResponse({
    this.list,
    this.itemCount,
  });
  WorkTypeResponse.fromJson(Map<String, dynamic> json) {
    itemCount = json["itemCount"];
    list = (json["body"] as List).map((json) => WorkType.fromJson(json)).toList();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["itemCount"] = itemCount;
    data["body"] = list;
    return data;
  }
}

class WorkType {
  String? id;
  String? name;
  String? description;

  WorkType({
    this.id,
    this.name,
    this.description,
  });

  WorkType.fromJson(Map<String, dynamic> json) {
    id = json["user_id"];
    name = json["full_name"];
    description = json["description"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = id;
    data["full_name"] = name;
    data["description"] = description;
    return data;
  }
}
