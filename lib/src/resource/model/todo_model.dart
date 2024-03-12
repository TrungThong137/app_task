class ToDoModel {
  ToDoModel({
    this.idUser,
    this.title,
    this.dateTime,
    this.idTodo,
    this.isCheckBox=false,
  });

  final String? idUser;
  final String? title;
  final String? dateTime;
  final String? idTodo;
  final bool isCheckBox;

  static ToDoModel fromJson(Map<String, dynamic> json) => ToDoModel(
      idUser: json['idUser'],
      title: json['title'],
      dateTime: json['dateTime'],
      idTodo: json['idTodo'],
      isCheckBox: json['isCheckBox'],
    );

  Map<String, dynamic> toJson() => {
      'isCheckBox': isCheckBox,
    };
}
