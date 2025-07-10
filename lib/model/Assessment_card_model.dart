class AssessmentCardModel {
  final String id;
  final String imageUrl;
  final String title;
  final String description;

  AssessmentCardModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  factory AssessmentCardModel.fromMap(Map<String, dynamic> map) {
    return AssessmentCardModel(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  // Convert to map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
    };
  }
}
