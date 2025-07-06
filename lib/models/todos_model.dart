class TodosModel {
  final String? userId;
  final String title;
  final bool completed;

  TodosModel({this.userId, required this.title, required this.completed});

  factory TodosModel.formJson(Map<String, dynamic> json) {
    return TodosModel(
      userId: json["userId"],
      title: json["title"],
      completed: json["Completed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"userId": "", "title": title, "Completed": completed};
  }
}
