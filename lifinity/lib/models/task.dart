class Task {
  int id;
  String title;
  String category;
  String time;
  String repeatType;
  String date;
  bool alarmEnabled;
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.category,
    required this.time,
    required this.repeatType,
    required this.date,
    required this.alarmEnabled,
    this.completed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'time': time,
      'repeatType': repeatType,
      'date': date,
      'alarmEnabled': alarmEnabled,
      'completed': completed,
    };
  }

  factory Task.fromJson(
    Map<String, dynamic> json,
  ) {
    return Task(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch,
      title: json['title'],
      category: json['category'],
      time: json['time'],
      repeatType: json['repeatType'],
      date: json['date'] ?? '',
      alarmEnabled: json['alarmEnabled'],
      completed: json['completed'],
    );
  }
}