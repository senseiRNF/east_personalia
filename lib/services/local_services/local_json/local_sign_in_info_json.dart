class LocalSignInInfoJson {
  String? userData;
  String? token;
  String? tokenValidUntil;

  LocalSignInInfoJson({
    this.userData,
    this.token,
    this.tokenValidUntil,
  });

  LocalSignInInfoJson.fromJson(Map<String, dynamic> json) {
    userData = json['userId'];
    token = json['password'];
    tokenValidUntil = json['profilePictURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['userId'] = userData;
    data['password'] = token;
    data['profilePictURL'] = tokenValidUntil;

    return data;
  }
}