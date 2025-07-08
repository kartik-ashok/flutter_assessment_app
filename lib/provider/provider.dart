import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assessment_app/model/Assessment_card_model.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';

class AssessmentCardProvider with ChangeNotifier {
  List<AssessmentCardModel> _cards = [];
  List<HealthService> _appointmentCards = [];
  bool _isLoading = false;

  List<AssessmentCardModel> get cards => _cards;
  List<HealthService> get appointmentCard => _appointmentCards;
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
}
