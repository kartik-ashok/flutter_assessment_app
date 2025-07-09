import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assessment_app/model/Assessment_card_model.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/model/workout_routins.dart';
import 'package:flutter_assessment_app/presentation/screens/my_appointment.dart';

class AssessmentCardProvider with ChangeNotifier {
  List<AssessmentCardModel> _cards = [];
  List<HealthService> _appointmentCards = [];
  List<WorkoutRoutine> _workoutRoutins = [];
  bool _isLoading = false;

  List<AssessmentCardModel> get cards => _cards;
  List<HealthService> get appointmentCard => _appointmentCards;
  List<WorkoutRoutine> get workoutRoutins => _workoutRoutins;
  bool get isLoading => _isLoading;

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
          .map((doc) => HealthService.fromMap(doc.data()))
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
}
