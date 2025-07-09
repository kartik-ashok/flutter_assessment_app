import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentService {
  Future<void> addAppointmentCardsToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final Map<String, dynamic> healthAppointment = {
      'id': 'appointment_001', // Unique ID for Firestore
      'name': 'Cancer 2nd Opinion', // Service name
      'type': 'Consultation', // Appointment type
      'doctorName': 'Dr. Asha Mehta', // Doctor name
      'doctorSpeciality': 'Oncologist', // Specialization
      'date': '2025-07-12', // Appointment date (YYYY-MM-DD)
      'time': '10:30 AM', // Appointment time
      'duration': '30 mins', // Duration
      'location': 'Online', // Location (Online / In-clinic)
      'isBooked': false, // Whether this slot is already booked
      'price': 1200, // Price of the appointment
      'description': 'Get a second opinion from an expert oncologist.', // Info
      'imageUrl':
          'https://example.com/doctor_photo.jpg', // Doctor/Service image
    };

    await firestore.collection('healthServices').add(healthAppointment);
  }

  Future<List<Map<String, dynamic>>> fetchAppointmentServices() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot =
        await firestore.collection('healthServices').get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> cacheAppointmentCards() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('assessmentCards')
        .get(const GetOptions(source: Source.cache)); // Fetch and cache

    // Optional: Access docs
    for (var doc in snapshot.docs) {
      print(doc.data());
    }
  }

  Future<void> bookAppointment(String appointmentId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    try {
      // Find the appointment document by ID
      final query = await firestore
          .collection('healthServices')
          .where('id', isEqualTo: appointmentId)
          .limit(1)
          .get();

      print(query);
      print(appointmentId);
      if (query.docs.isEmpty) {
        throw Exception('Appointment not found');
      }

      final docRef = query.docs.first.reference;

      // Update the appointment to mark as booked and add userId
      await docRef.update({
        'isBooked': true,
        'bookedBy': currentUser.uid,
        'bookedAt': FieldValue.serverTimestamp(),
      });

      print('Appointment booked successfully');
    } catch (e) {
      print('Error booking appointment: $e');
      rethrow;
    }
  }
}
