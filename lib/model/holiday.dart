class HolidayResponse {
  List<Holiday>? list;

  HolidayResponse({
    this.list,
  });
  HolidayResponse.fromJson(Map<String, dynamic> json) {
    list = (json["body"] as List).map((json) => Holiday.fromJson(json)).toList();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["body"] = list;
    return data;
  }
}

class Holiday {
  int? id;
  String? name;
  DateTime? startFrom;
  DateTime? endAt;
  String? dayAmount;
  String? description;
 Holiday({
    this.id,
    this.name,
    this.startFrom,
    this.endAt,
    this.dayAmount,
    this.description,
  });

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json["holiday_id"];
    name = json["company_id"];
    startFrom = json["startFrom"];
    dayAmount = json["dayAmount"];
    endAt = json["postal_code"];
    description=json["holiday_code"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["holiday_id"] = id;
    data["company_id"] = name;
    data["startFrom"] = startFrom;
    data["dayAmount"] = dayAmount;
    data["postal_code"]=endAt ;
    data["holiday_code"]=description;
    return data;
  }
}
