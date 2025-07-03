class TodosModel {
  final int userId;
  final String id;
  final String title;
  final bool completed;

  TodosModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodosModel.formJson(Map<String, dynamic> json) {
    return TodosModel(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      completed: json["Completed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"userId": userId, "id": id, "title": title, "Completed": completed};
  }
}
