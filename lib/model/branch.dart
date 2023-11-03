class BranchResponse {
  List<Branch>? list;

  BranchResponse({
    this.list,
  });
  BranchResponse.fromJson(Map<String, dynamic> json) {
    list = (json["body"] as List).map((json) => Branch.fromJson(json)).toList();

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["body"] = list;
    return data;
  }
}

class Branch {
  int? id;
  String? companyId;
  String? address;
  String? postalCode;
  String? country;
  String? branchCode;
  String? domain;
  String? server;

 Branch({
    this.id,
    this.companyId,
    this.address,
    this.postalCode,
    this.country,
    this.branchCode,
    this.domain,
    this.server,
  });

  Branch.fromJson(Map<String, dynamic> json) {
    id = json["branch_id"];
    companyId = json["company_id"];
    address = json["address"];
    country = json["country"];
    postalCode = json["postal_code"];
    branchCode=json["branch_code"];
    domain=json["domain"];
    server=json["server"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["branch_id"] = id;
    data["company_id"] = companyId;
    data["address"] = address;
    data["country"] = country;
    data["postal_code"]=postalCode ;
    data["branch_code"]=branchCode;
    data["domain"]=domain;
    data["server"]=server;
    return data;
  }
}
