class InputScreenModel {
  InputScreenModel({
    this.idUser,
    this.bodyFat,
    this.weight,
    this.note,
    this.idIconStamp,
    this.dateTime,
    this.idInput,
  });

  final String? idUser;
  final double? bodyFat;
  final double? weight;
  final String? note;
  final int? idIconStamp;
  final String? dateTime;
  final String? idInput;

  static InputScreenModel fromJson(Map<String, dynamic> json) => InputScreenModel(
      idUser: json['idUser'],
      bodyFat: json['bodyFat'],
      weight: json['weight'],
      note: json['note'],
      idIconStamp: json['idIconStamp'],
      dateTime: json['dateTime'],
      idInput: json['idInput'],
    );

  Map<String, dynamic> toJson() => {
      'idUser': idUser,
      'bodyFat': bodyFat,
      'note': note,
      'weight': weight,
      'idIconStamp': idIconStamp,
      'dateTime': dateTime,
      'idInput': idInput,
    };
}
