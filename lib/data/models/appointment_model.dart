/// Appointment data model
class AppointmentModel {
  final String id;
  final String title;
  final String description;
  final AppointmentType type;
  final AppointmentStatus status;
  final DateTime scheduledAt;
  final DateTime? completedAt;
  final String? doctorName;
  final String? location;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AppointmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.scheduledAt,
    this.completedAt,
    this.doctorName,
    this.location,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create AppointmentModel from JSON
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: AppointmentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AppointmentType.general,
      ),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.scheduled,
      ),
      scheduledAt: DateTime.parse(json['scheduled_at'] as String),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      doctorName: json['doctor_name'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert AppointmentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'status': status.name,
      'scheduled_at': scheduledAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'doctor_name': doctorName,
      'location': location,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create a copy of AppointmentModel with updated fields
  AppointmentModel copyWith({
    String? id,
    String? title,
    String? description,
    AppointmentType? type,
    AppointmentStatus? status,
    DateTime? scheduledAt,
    DateTime? completedAt,
    String? doctorName,
    String? location,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      completedAt: completedAt ?? this.completedAt,
      doctorName: doctorName ?? this.doctorName,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppointmentModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.type == type &&
        other.status == status &&
        other.scheduledAt == scheduledAt &&
        other.completedAt == completedAt &&
        other.doctorName == doctorName &&
        other.location == location &&
        other.notes == notes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      type,
      status,
      scheduledAt,
      completedAt,
      doctorName,
      location,
      notes,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'AppointmentModel(id: $id, title: $title, description: $description, type: $type, status: $status, scheduledAt: $scheduledAt, completedAt: $completedAt, doctorName: $doctorName, location: $location, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// Appointment type enumeration
enum AppointmentType {
  general,
  cancer,
  physiotherapy,
  fitness,
  nutrition,
  mental,
}

/// Appointment status enumeration
enum AppointmentStatus {
  scheduled,
  confirmed,
  inProgress,
  completed,
  cancelled,
  noShow,
}
