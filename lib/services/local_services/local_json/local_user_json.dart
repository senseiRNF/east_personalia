class LocalUserJson {
  String? userId;
  String? password;
  String? profilePictURL;
  String? username;
  String? identityNumber;
  String? placeOfBirth;
  String? dateOfBirth;
  String? gender;
  String? phone;
  String? email;
  String? address;
  String? emergencyNumber;
  String? npwp;
  String? company;
  String? level;
  String? role;

  LocalUserJson({
    this.userId,
    this.password,
    this.profilePictURL,
    this.username,
    this.identityNumber,
    this.placeOfBirth,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.email,
    this.address,
    this.emergencyNumber,
    this.npwp,
    this.company,
    this.level,
    this.role,
  });

  LocalUserJson.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    password = json['password'];
    profilePictURL = json['profilePictURL'];
    username = json['username'];
    identityNumber = json['identityNumber'];
    placeOfBirth = json['placeOfBirth'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    emergencyNumber = json['emergencyNumber'];
    npwp = json['npwp'];
    company = json['company'];
    level = json['level'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['userId'] = userId;
    data['password'] = password;
    data['profilePictURL'] = profilePictURL;
    data['username'] = username;
    data['identityNumber'] = identityNumber;
    data['placeOfBirth'] = placeOfBirth;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['emergencyNumber'] = emergencyNumber;
    data['npwp'] = npwp;
    data['company'] = company;
    data['level'] = level;
    data['role'] = role;

    return data;
  }
}