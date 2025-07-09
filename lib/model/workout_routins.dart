class WorkoutRoutine {
  final String name;
  final String sweatStart;
  final String bodyType;
  final String weightGoal;
  final String difficultyLevel;

  WorkoutRoutine({
    required this.name,
    required this.sweatStart,
    required this.bodyType,
    required this.weightGoal,
    required this.difficultyLevel,
  });

  factory WorkoutRoutine.fromJson(Map<String, dynamic> json) {
    return WorkoutRoutine(
      name: json['name'],
      sweatStart: json['sweatStart'],
      bodyType: json['bodyType'],
      weightGoal: json['weightGoal'],
      difficultyLevel: json['difficultyLevel'],
    );
  }
}
