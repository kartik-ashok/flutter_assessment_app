import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assessment_app/model/Assessment_card_model.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/model/workout_routins.dart';
import 'package:flutter_assessment_app/presentation/screens/my_appointment.dart';

class AssessmentCardProvider with ChangeNotifier {
  List<AssessmentCardModel> _cards = [];
  List<AppointmentModel> _appointmentCards = [];
  List<WorkoutRoutine> _workoutRoutins = [];
  bool _isLoading = false;
  Set<String> _bookingAppointments =
      {}; // Track which appointments are being booked
  String? _bookingMessage;

  List<AssessmentCardModel> get cards => _cards;
  List<AppointmentModel> get appointmentCard => _appointmentCards;
  List<WorkoutRoutine> get workoutRoutins => _workoutRoutins;
  bool get isLoading => _isLoading;
  String? get bookingMessage => _bookingMessage;

  // Check if a specific appointment is being booked
  bool isBookingAppointment(String appointmentId) {
    return _bookingAppointments.contains(appointmentId);
  }

  Future<void> fetchCards() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('assessmentCards').get();

      _cards = snapshot.docs
          .map((doc) => AssessmentCardModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching cards: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAppointmentCards() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('healthServices').get();

      _appointmentCards = snapshot.docs
          .map((doc) => AppointmentModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching cards: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWorkoutRoutines() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('workoutRoutines').get();

      _workoutRoutins = snapshot.docs
          .map((doc) => WorkoutRoutine.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching cards: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear booking message
  void clearBookingMessage() {
    _bookingMessage = null;
    notifyListeners();
  }

  // Book appointment functionality
  Future<bool> bookAppointment(String appointmentId) async {
    // Add this appointment to the booking set
    _bookingAppointments.add(appointmentId);
    _bookingMessage = null;
    notifyListeners();

    try {
      // Check if user is authenticated, if not sign in anonymously
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        try {
          final userCredential =
              await FirebaseAuth.instance.signInAnonymously();
          currentUser = userCredential.user;
        } catch (e) {
          _bookingMessage = 'Authentication failed. Please try again.';
          _bookingAppointments.remove(appointmentId);
          notifyListeners();
          return false;
        }
      }

      if (currentUser == null) {
        _bookingMessage = 'Authentication failed. Please try again.';
        _bookingAppointments.remove(appointmentId);
        notifyListeners();
        return false;
      }

      // Find the appointment document by ID
      final query = await FirebaseFirestore.instance
          .collection('healthServices')
          .where('id', isEqualTo: appointmentId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        _bookingMessage = 'Appointment not found';
        _bookingAppointments.remove(appointmentId);
        notifyListeners();
        return false;
      }

      final docRef = query.docs.first.reference;
      final appointmentData = query.docs.first.data();

      // Check if already booked
      if (appointmentData['isBooked'] == true) {
        _bookingMessage = 'This appointment is already booked';
        _bookingAppointments.remove(appointmentId);
        notifyListeners();
        return false;
      }

      // Update the appointment to mark as booked
      await docRef.update({
        'isBooked': true,
        'bookedBy': currentUser.uid,
        'bookedAt': FieldValue.serverTimestamp(),
      });

      // Update local state immediately
      final appointmentIndex = _appointmentCards.indexWhere(
        (appointment) => appointment.id == appointmentId,
      );

      if (appointmentIndex != -1) {
        _appointmentCards[appointmentIndex] = AppointmentModel(
          docId: _appointmentCards[appointmentIndex].docId,
          id: _appointmentCards[appointmentIndex].id,
          name: _appointmentCards[appointmentIndex].name,
          type: _appointmentCards[appointmentIndex].type,
          doctorName: _appointmentCards[appointmentIndex].doctorName,
          doctorSpeciality:
              _appointmentCards[appointmentIndex].doctorSpeciality,
          date: _appointmentCards[appointmentIndex].date,
          time: _appointmentCards[appointmentIndex].time,
          duration: _appointmentCards[appointmentIndex].duration,
          location: _appointmentCards[appointmentIndex].location,
          isBooked: true, // Mark as booked
          price: _appointmentCards[appointmentIndex].price,
          description: _appointmentCards[appointmentIndex].description,
          imageUrl: _appointmentCards[appointmentIndex].imageUrl,
        );
      }

      _bookingMessage = 'Appointment booked successfully!';
      _bookingAppointments.remove(appointmentId);
      notifyListeners();
      return true;
    } catch (e) {
      _bookingMessage = 'Failed to book appointment. Please try again.';
      _bookingAppointments.remove(appointmentId);
      notifyListeners();
      return false;
    }
  }
}
