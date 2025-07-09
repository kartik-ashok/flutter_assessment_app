import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  Future<void> addAppointmentCardsToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final Map<String, String> healthServices = {
      'name': 'Cancer 2nd Opinion',
      'type': 'Consultation'
    };

    await firestore.collection('healthServices').add(healthServices);
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
