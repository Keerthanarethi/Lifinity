class Goal {
  String title;
  int progress;
  int target;

  Goal({
    required this.title,
    required this.progress,
    required this.target,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'progress': progress,
      'target': target,
    };
  }

  factory Goal.fromJson(
      Map<String, dynamic> json) {
    return Goal(
      title: json['title'],
      progress: json['progress'],
      target: json['target'],
    );
  }
}
