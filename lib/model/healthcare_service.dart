class HealthService {
  final String name;
  final String type;

  HealthService({required this.name, required this.type});
  factory HealthService.fromMap(Map<String, dynamic> map) {
    return HealthService(
      name: map['name'] ?? '',
      type: map['type'] ?? '',
    );
  }
}
