class Users {
  Users({
    this.idUser,
    this.fullName,
    this.emailAddress,
  });

  final String? idUser;
  final String? fullName;
  final String? emailAddress;

  static Users fromJson(Map<String, dynamic> json) => Users(
        idUser: json['idUser'],
        fullName: json['fullName'],
        emailAddress: json['emailAddress'],
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'fullName': fullName,
        'emailAddress': emailAddress,
      };
}
