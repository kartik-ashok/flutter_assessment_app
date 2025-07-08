import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  Future<void> addAssessmentCardsToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final List<Map<String, String>> healthServices = [
      {'name': 'Cancer 2nd Opinion', 'type': 'Consultation'},
      {'name': 'Physiotherapy', 'type': 'Treatment'},
      {'name': 'Doctor Appointment', 'type': 'Appointment'},
      {'name': 'Fitness', 'type': 'Wellness'},
      {'name': 'Dental Checkup', 'type': 'Appointment'},
      {'name': 'Mental Health Therapy', 'type': 'Therapy'},
      {'name': 'Nutrition Consultation', 'type': 'Wellness'},
      {'name': 'Cardiology', 'type': 'Specialty'},
      {'name': 'Dermatology', 'type': 'Specialty'},
      {'name': 'Home Care Services', 'type': 'HomeCare'},
      {'name': 'Child Health', 'type': 'Pediatrics'},
      {'name': 'Lab Test Booking', 'type': 'Diagnostics'},
      {'name': 'Online Consultation', 'type': 'Telemedicine'},
      {'name': 'Eye Checkup', 'type': 'Appointment'},
      {'name': 'Vaccination', 'type': 'Preventive Care'},
    ];

    for (var card in healthServices) {
      await firestore.collection('healthServices').add(card);
    }
  }

  Future<List<Map<String, dynamic>>> fetchAppointmentServices() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot =
        await firestore.collection('healthServices').get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
