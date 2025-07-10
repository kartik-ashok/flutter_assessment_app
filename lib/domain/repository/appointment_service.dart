import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentService {
  Future<void> addAppointmentCardsToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final List<Map<String, dynamic>> healthAppointments = [
      {
        'id': 'appointment_001',
        'name': 'Cancer 2nd Opinion',
        'type': 'Consultation',
        'doctorName': 'Dr. Asha Mehta',
        'doctorSpeciality': 'Oncologist',
        'date': '2025-07-12',
        'time': '10:30 AM',
        'duration': '30 mins',
        'location': 'Online',
        'isBooked': false,
        'price': 1200,
        'description': 'Get a second opinion from an expert oncologist.',
        'imageUrl': 'https://example.com/doctor_photo.jpg',
      },
      {
        'id': 'appointment_002',
        'name': 'Cardiology Checkup',
        'type': 'Consultation',
        'doctorName': 'Dr. Rajesh Kumar',
        'doctorSpeciality': 'Cardiologist',
        'date': '2025-07-13',
        'time': '2:00 PM',
        'duration': '45 mins',
        'location': 'In-clinic',
        'isBooked': false,
        'price': 800,
        'description': 'Complete heart health checkup and consultation.',
        'imageUrl': 'https://example.com/cardio_doctor.jpg',
      },
      {
        'id': 'appointment_003',
        'name': 'Dermatology Visit',
        'type': 'Consultation',
        'doctorName': 'Dr. Priya Sharma',
        'doctorSpeciality': 'Dermatologist',
        'date': '2025-07-14',
        'time': '11:00 AM',
        'duration': '30 mins',
        'location': 'Online',
        'isBooked': false,
        'price': 600,
        'description': 'Skin health consultation and treatment advice.',
        'imageUrl': 'https://example.com/derma_doctor.jpg',
      },
    ];

    for (var appointment in healthAppointments) {
      await firestore.collection('healthServices').add(appointment);
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
