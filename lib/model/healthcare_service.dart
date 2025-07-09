class AppointmentModel {
  final String docId;
  final String id;
  final String name;
  final String type;
  final String doctorName;
  final String doctorSpeciality;
  final String date;
  final String time;
  final String duration;
  final String location;
  final bool isBooked;
  final int price;
  final String description;
  final String imageUrl;

  AppointmentModel({
    required this.docId,
    required this.id,
    required this.name,
    required this.type,
    required this.doctorName,
    required this.doctorSpeciality,
    required this.date,
    required this.time,
    required this.duration,
    required this.location,
    required this.isBooked,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  // Factory constructor to create from Firestore map
  factory AppointmentModel.fromMap(Map<String, dynamic> map, String docId) {
    return AppointmentModel(
      docId: docId,
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      doctorName: map['doctorName'] ?? '',
      doctorSpeciality: map['doctorSpeciality'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      duration: map['duration'] ?? '',
      location: map['location'] ?? '',
      isBooked: map['isBooked'] ?? false,
      price: map['price'] ?? 0,
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'doctorName': doctorName,
      'doctorSpeciality': doctorSpeciality,
      'date': date,
      'time': time,
      'duration': duration,
      'location': location,
      'isBooked': isBooked,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
