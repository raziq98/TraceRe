class CompanyResponse {
  List<Company>? list;

  CompanyResponse({
    this.list,
  });
  CompanyResponse.fromJson(Map<String, dynamic> json) {
    list = (json["body"] as List).map((json) => Company.fromJson(json)).toList();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["body"] = list;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? photo;
  String? phone;
  String? email;
  String? companyBio;
  String? branchId;
  String? establishedDate;

 Company({
    this.id,
    this.name,
    this.photo,
    this.phone,
    this.email,
    this.branchId,
    this.companyBio,
    this.establishedDate,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json["company_id"];
    name = json["company_name"];
    email = json["email"];
    phone = json["phone"];
    photo=json["photo"];
    establishedDate = json["established_date"];
    branchId = json["branch_id"];
    companyBio = json["company_bio"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["company_id"] = id;
    data["company_name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["established_date"] = establishedDate;
    data["branch_id"] = branchId;
    data["self_introduction"] = companyBio;
    data["profile_picture"] = photo;
    return data;
  }
}
