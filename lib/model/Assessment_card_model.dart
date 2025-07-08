class AssessmentCardModel {
  final String imageUrl;
  final String title;
  final String description;

  AssessmentCardModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  factory AssessmentCardModel.fromMap(Map<String, dynamic> map) {
    return AssessmentCardModel(
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
