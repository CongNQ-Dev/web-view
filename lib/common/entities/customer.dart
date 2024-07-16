class CustomerItem {
  String? access_token;
  String? tokenType;
  String? userID;
  int? expiresIn;
  String? userName;
  String? phoneNumber;
  String? name;
  String? avatar;
  String? dateLogin;

  CustomerItem(
      {this.access_token,
      this.tokenType,
      this.userID,
      this.expiresIn,
      this.userName,
      this.phoneNumber,
      this.name,
      this.avatar,
      this.dateLogin});

  factory CustomerItem.fromJson(Map<String, dynamic> json) => CustomerItem(
        access_token: json["access_token"],
        tokenType: json["tokenType"],
        userID: json["userID"],
        expiresIn: json["expiresIn"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        name: json['name'],
        avatar: json["avatar"],
        dateLogin: json["dateLogin"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": access_token,
        "tokenType": tokenType,
        "userID": userID,
        "expiresIn": expiresIn,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "name": name,
        "avatar": avatar,
        "dateLogin": dateLogin,
      };
}

class ExternalLogin {
  String? provider;
  String? idToken;

  ExternalLogin({
    this.provider,
    this.idToken,
  });

  Map<String, dynamic> toJson() => {
        "provider": provider,
        "idToken": idToken,
      };
}
