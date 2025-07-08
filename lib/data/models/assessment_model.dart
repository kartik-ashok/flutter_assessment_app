/// Assessment data model
class AssessmentModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final AssessmentType type;
  final AssessmentStatus status;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? results;

  const AssessmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.status,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.results,
  });

  /// Create AssessmentModel from JSON
  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      type: AssessmentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AssessmentType.fitness,
      ),
      status: AssessmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AssessmentStatus.notStarted,
      ),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      results: json['results'] as Map<String, dynamic>?,
    );
  }

  /// Convert AssessmentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'type': type.name,
      'status': status.name,
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'results': results,
    };
  }

  /// Create a copy of AssessmentModel with updated fields
  AssessmentModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    AssessmentType? type,
    AssessmentStatus? status,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? results,
  }) {
    return AssessmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      results: results ?? this.results,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AssessmentModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.type == type &&
        other.status == status &&
        other.completedAt == completedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      imageUrl,
      type,
      status,
      completedAt,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'AssessmentModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, type: $type, status: $status, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// Assessment type enumeration
enum AssessmentType {
  fitness,
  healthRisk,
  nutrition,
  mental,
}

/// Assessment status enumeration
enum AssessmentStatus {
  notStarted,
  inProgress,
  completed,
  expired,
}
