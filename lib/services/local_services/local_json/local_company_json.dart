class LocalCompanyJson {
  String? companyId;
  String? companyName;
  String? companyIdentityNumber;
  String? companyType;
  String? dateOfEstablishment;
  String? companyPhone;
  String? companyEmail;
  String? companyAddress;
  String? companyRegion;
  String? companyPIC;

  LocalCompanyJson({
    this.companyId,
    this.companyName,
    this.companyIdentityNumber,
    this.companyType,
    this.dateOfEstablishment,
    this.companyPhone,
    this.companyEmail,
    this.companyAddress,
    this.companyRegion,
    this.companyPIC,
  });

  LocalCompanyJson.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    companyIdentityNumber = json['companyIdentityNumber'];
    companyType = json['companyType'];
    dateOfEstablishment = json['dateOfEstablishment'];
    companyPhone = json['companyPhone'];
    companyEmail = json['companyEmail'];
    companyAddress = json['companyAddress'];
    companyRegion = json['companyRegion'];
    companyPIC = json['companyPIC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['companyIdentityNumber'] = companyIdentityNumber;
    data['companytype'] = companyType;
    data['dateOfEstablishment'] = dateOfEstablishment;
    data['companyPhone'] = companyPhone;
    data['companyEmail'] = companyEmail;
    data['companyAddress'] = companyAddress;
    data['companyRegion'] = companyRegion;
    data['companyPIC'] = companyPIC;

    return data;
  }
}