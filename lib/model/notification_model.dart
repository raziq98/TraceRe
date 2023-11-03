class NotificationResponse {
  List<MyNotification>? list;

  NotificationResponse({
    this.list,
  });
  NotificationResponse.fromJson(Map<String, dynamic> json) {
    list = (json["body"] as List).map((json) => MyNotification.fromJson(json)).toList();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["body"] = list;
    return data;
  }
}

class MyNotification {
  String? id;
  String? sender;
  DateTime? createdDate;
  int? statusId;
  String? sendTo;
  String? requestType;
  DateTime? requestedDateFrom;
  DateTime? requestedDateTo;
  String? description;
  String? suggestion;
  bool isRead=false;

  MyNotification({
    this.id,
    this.sender,
    this.createdDate,
    this.statusId,
    this.sendTo,
    this.requestType,
    this.requestedDateFrom,
    this.requestedDateTo,
    this.description,
    this.suggestion,
  });

  MyNotification.fromJson(Map<String, dynamic> json) {
    id=json["id"];
    sender = json["user_id"];
    createdDate = json["created_date"];
    statusId = json["status_id"];
    sendTo = json["approver_name"];
    requestType = json["request_type"];
    requestedDateFrom=json["requested_date_from"];
    requestedDateTo = json["requested_date_to"];
    description = json["description"];
    suggestion=json["suggestion"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"]=id;
    data["user_id"] = sender;
    data["created_date"] = createdDate;
    data["status_id"] = statusId;
    data["approver_name"] = sendTo;
    data["request_type"]=requestType ;
    data["requested_date_from"]=requestedDateFrom;
    data["requested_date_to"] = requestedDateTo;
    data["description"]=description ;
    data["suggestion"]=suggestion;
    return data;
    }

}
