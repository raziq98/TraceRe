class UserResponse {
  int? itemCount;
  List<User>? list;

  UserResponse({
    this.list,
    this.itemCount,
  });
  UserResponse.fromJson(Map<String, dynamic> json) {
    itemCount = json["itemCount"];
    list = (json["body"] as List).map((json) => User.fromJson(json)).toList();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["itemCount"] = itemCount;
    data["body"] = list;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? userCode;
  String? address;
  String? postalCode;
  String? country;
  String? photo;
  String? phone;
  String? email;
  String? password;
  int? roleId;
  String? branchCode;
  int? departmentId;
  bool? isAvailable;
  bool? isOffDay;
  String? dateOfBirth;

 User({
    this.id,
    this.name,
    this.userCode,
    this.address,
    this.postalCode,
    this.country,
    this.photo,
    this.phone,
    this.email,
    this.password,
    this.roleId,
    this.branchCode,
    this.departmentId,
    this.isAvailable,
    this.isOffDay,
    this.dateOfBirth,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["user_id"];
    name = json["full_name"];
    email = json["email"];
    userCode = json["userCode"];
    address = json["address"];
    country = json["country"];
    phone = json["phone"];
    password = json["password"];
    dateOfBirth = json["date_of_birth"];
    roleId = json["current_job"];
    branchCode = json["current_company"];
    departmentId = json["self_introduction"];
    photo = json["profile_picture"];
    isAvailable = json["isAvailable"];
    isOffDay = json["isOffDay"];
    postalCode = json["postal_code"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = id;
    data["full_name"] = name;
    data["email"] = email;
    data["userCode"] = userCode;
    data["address"] = address;
    data["country"] = country;
    data["phone"] = phone;
    data["password"] = password;
    data["date_of_birth"] = dateOfBirth;
    data["current_job"] = roleId;
    data["current_company"] = branchCode;
    data["self_introduction"] = departmentId;
    data["profile_picture"] = photo;
    data["isAvailable"] = isAvailable;
    data["isOffDay"] = isOffDay;
    data["postal_code"]=postalCode ;
    return data;
  }
}
