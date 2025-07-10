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
  bool _isUsingCachedData = false;

  List<AssessmentCardModel> get cards => _cards;
  List<AppointmentModel> get appointmentCard => _appointmentCards;
  List<WorkoutRoutine> get workoutRoutins => _workoutRoutins;
  bool get isLoading => _isLoading;
  String? get bookingMessage => _bookingMessage;
  bool get isUsingCachedData => _isUsingCachedData;

  // Check if a specific appointment is being booked
  bool isBookingAppointment(String appointmentId) {
    return _bookingAppointments.contains(appointmentId);
  }

  Future<void> fetchCards({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot snapshot;

      // Always try cache first (offline-first approach)
      try {
        snapshot = await FirebaseFirestore.instance
            .collection('assessmentCards')
            .get(const GetOptions(source: Source.cache));
        _isUsingCachedData = true;

        // Show offline message when using cached data
        if (_cards.isEmpty || forceRefresh) {
          _bookingMessage =
              'Showing offline data. Pull to refresh to reload cached data.';
        }
      } catch (e) {
        // If cache fails and we're forcing refresh, try server as fallback
        if (forceRefresh) {
          try {
            snapshot = await FirebaseFirestore.instance
                .collection('assessmentCards')
                .get(const GetOptions(source: Source.server));
            _isUsingCachedData = false;
            _bookingMessage = null; // Clear offline message if server works
          } catch (serverError) {
            // Server also failed, show error message
            _bookingMessage = 'No internet connection. Unable to load data.';
            return;
          }
        } else {
          // Not forcing refresh and cache failed, show error
          _bookingMessage =
              'No cached data available. Check internet connection.';
          return;
        }
      }

      _cards = snapshot.docs
          .map((doc) =>
              AssessmentCardModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching cards: $e');
      _bookingMessage = 'Error loading data. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAppointmentCards({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot snapshot;

      // Always try cache first (offline-first approach)
      try {
        snapshot = await FirebaseFirestore.instance
            .collection('healthServices')
            .get(const GetOptions(source: Source.cache));
        _isUsingCachedData = true;
      } catch (e) {
        // If cache fails and we're forcing refresh, try server as fallback
        if (forceRefresh) {
          try {
            snapshot = await FirebaseFirestore.instance
                .collection('healthServices')
                .get(const GetOptions(source: Source.server));
            _isUsingCachedData = false;
          } catch (serverError) {
            // Server also failed, keep existing data
            return;
          }
        } else {
          // Not forcing refresh and cache failed, keep existing data
          return;
        }
      }

      _appointmentCards = snapshot.docs
          .map((doc) => AppointmentModel.fromMap(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching appointment cards: $e');
      // If all fails and we have no data, keep existing data
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWorkoutRoutines({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot snapshot;

      // Always try cache first (offline-first approach)
      try {
        snapshot = await FirebaseFirestore.instance
            .collection('workoutRoutines')
            .get(const GetOptions(source: Source.cache));
        _isUsingCachedData = true;
      } catch (e) {
        // If cache fails and we're forcing refresh, try server as fallback
        if (forceRefresh) {
          try {
            snapshot = await FirebaseFirestore.instance
                .collection('workoutRoutines')
                .get(const GetOptions(source: Source.server));
            _isUsingCachedData = false;
          } catch (serverError) {
            // Server also failed, keep existing data
            return;
          }
        } else {
          // Not forcing refresh and cache failed, keep existing data
          return;
        }
      }

      _workoutRoutins = snapshot.docs
          .map((doc) =>
              WorkoutRoutine.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching workout routines: $e');
      // If all fails and we have no data, keep existing data
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh cached data (for pull-to-refresh) - prioritizes offline data
  Future<void> refreshAllData() async {
    _bookingMessage = null; // Clear any previous messages
    await Future.wait([
      fetchCards(forceRefresh: true),
      fetchAppointmentCards(forceRefresh: true),
      fetchWorkoutRoutines(forceRefresh: true),
    ]);
  }

  // Load cached data first (for offline support)
  Future<void> loadCachedData() async {
    await Future.wait([
      fetchCards(forceRefresh: false),
      fetchAppointmentCards(forceRefresh: false),
      fetchWorkoutRoutines(forceRefresh: false),
    ]);
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
