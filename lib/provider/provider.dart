import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assessment_app/localStorage/favorite_service.dart';
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
  Set<String> _favoriteAssessments = {}; // Track favorite assessment IDs

  List<AssessmentCardModel> get cards => _cards;
  List<AppointmentModel> get appointmentCard => _appointmentCards;
  List<WorkoutRoutine> get workoutRoutins => _workoutRoutins;
  bool get isLoading => _isLoading;
  String? get bookingMessage => _bookingMessage;
  bool get isUsingCachedData => _isUsingCachedData;
  Set<String> get favoriteAssessments => _favoriteAssessments;

  // Check if a specific appointment is being booked
  bool isBookingAppointment(String appointmentId) {
    return _bookingAppointments.contains(appointmentId);
  }

  Future<void> fetchCards({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Try server first for latest data
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('assessmentCards').get();

      _cards = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add document ID to the data
        return AssessmentCardModel.fromMap(data);
      }).toList();

      // If no data exists, add sample data
      if (_cards.isEmpty) {
        await _addSampleAssessmentCards();
        // Fetch again
        snapshot = await FirebaseFirestore.instance
            .collection('assessmentCards')
            .get();
        _cards = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return AssessmentCardModel.fromMap(data);
        }).toList();
      }

      _isUsingCachedData = false;
      _bookingMessage = null;
    } catch (e) {
      print('Error fetching cards: $e');
      _bookingMessage = 'Error loading data. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add sample assessment cards
  Future<void> _addSampleAssessmentCards() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final List<Map<String, dynamic>> assessmentCards = [
      {
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
        'title': 'Health Risk Assessment',
        'description':
            'Identify And Mitigate Health Risks With Precise, Proactive Assessments',
      },
      {
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
        'title': 'Mental Health Screening',
        'description':
            'Comprehensive mental wellness evaluation and stress assessment',
      },
      {
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
        'title': 'Fitness Assessment',
        'description':
            'Evaluate your physical fitness level and create personalized workout plans',
      },
      {
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
        'title': 'Nutrition Analysis',
        'description':
            'Analyze your dietary habits and get personalized nutrition recommendations',
      },
    ];

    for (var card in assessmentCards) {
      await firestore.collection('assessmentCards').add(card);
    }
  }

  Future<void> fetchAppointmentCards({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Try to fetch from server first
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('healthServices').get();

      _appointmentCards = snapshot.docs
          .map((doc) => AppointmentModel.fromMap(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      // If no data exists, add sample data
      if (_appointmentCards.isEmpty) {
        await _addSampleAppointments();
        // Fetch again
        snapshot =
            await FirebaseFirestore.instance.collection('healthServices').get();
        _appointmentCards = snapshot.docs
            .map((doc) => AppointmentModel.fromMap(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList();
      }

      _isUsingCachedData = false;
    } catch (e) {
      print('Error fetching appointment cards: $e');
      // If all fails and we have no data, keep existing data
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add sample appointments
  Future<void> _addSampleAppointments() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final List<Map<String, dynamic>> appointments = [
      {
        'name': 'Cancer 2nd Opinion',
        'type': 'Consultation',
        'doctorName': 'Dr. Asha Mehta',
        'doctorSpeciality': 'Oncologist',
        'date': '2025-07-15',
        'time': '10:30 AM',
        'duration': '30 mins',
        'location': 'Online',
        'isBooked': false,
        'price': 1200,
        'description':
            'Get a second opinion from an expert oncologist for cancer diagnosis and treatment options.',
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
      },
      {
        'name': 'Heart Health Checkup',
        'type': 'Screening',
        'doctorName': 'Dr. Rajesh Kumar',
        'doctorSpeciality': 'Cardiologist',
        'date': '2025-07-16',
        'time': '2:00 PM',
        'duration': '45 mins',
        'location': 'In-clinic',
        'isBooked': false,
        'price': 800,
        'description':
            'Comprehensive heart health screening including ECG and blood pressure monitoring.',
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
      },
      {
        'name': 'Mental Health Consultation',
        'type': 'Therapy',
        'doctorName': 'Dr. Priya Sharma',
        'doctorSpeciality': 'Psychiatrist',
        'date': '2025-07-17',
        'time': '11:00 AM',
        'duration': '60 mins',
        'location': 'Online',
        'isBooked': false,
        'price': 1000,
        'description':
            'Professional mental health consultation and therapy session.',
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
      },
      {
        'name': 'Diabetes Management',
        'type': 'Follow-up',
        'doctorName': 'Dr. Suresh Patel',
        'doctorSpeciality': 'Endocrinologist',
        'date': '2025-07-18',
        'time': '9:30 AM',
        'duration': '30 mins',
        'location': 'In-clinic',
        'isBooked': false,
        'price': 600,
        'description':
            'Diabetes management consultation and medication review.',
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
      },
      {
        'name': 'General Health Checkup',
        'type': 'Screening',
        'doctorName': 'Dr. Anita Singh',
        'doctorSpeciality': 'General Physician',
        'date': '2025-07-19',
        'time': '4:00 PM',
        'duration': '30 mins',
        'location': 'In-clinic',
        'isBooked': false,
        'price': 500,
        'description':
            'Complete general health checkup with basic tests and consultation.',
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
      },
    ];

    for (var appointment in appointments) {
      await firestore.collection('healthServices').add(appointment);
    }
  }

  Future<void> fetchWorkoutRoutines({bool forceRefresh = false}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Try to fetch from server first
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('workoutRoutines').get();

      _workoutRoutins = snapshot.docs
          .map((doc) =>
              WorkoutRoutine.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // If no data exists, add sample data
      if (_workoutRoutins.isEmpty) {
        await _addSampleWorkoutRoutines();
        // Fetch again
        snapshot = await FirebaseFirestore.instance
            .collection('workoutRoutines')
            .get();
        _workoutRoutins = snapshot.docs
            .map((doc) =>
                WorkoutRoutine.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      }

      _isUsingCachedData = false;
    } catch (e) {
      print('Error fetching workout routines: $e');
      // If all fails and we have no data, keep existing data
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add sample workout routines
  Future<void> _addSampleWorkoutRoutines() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final List<Map<String, dynamic>> workoutRoutines = [
      {
        "name": "Full Body Burner",
        "sweatStart": "5 min",
        "bodyType": "Full Body",
        "weightGoal": "Lose",
        "difficultyLevel": "Medium",
      },
      {
        "name": "Upper Body Blast",
        "sweatStart": "3 min",
        "bodyType": "Upper Body",
        "weightGoal": "Gain",
        "difficultyLevel": "Hard",
      },
      {
        "name": "Core Crusher",
        "sweatStart": "4 min",
        "bodyType": "Core",
        "weightGoal": "Tone",
        "difficultyLevel": "Easy",
      },
      {
        "name": "Leg Day Legends",
        "sweatStart": "6 min",
        "bodyType": "Lower Body",
        "weightGoal": "Lose",
        "difficultyLevel": "Hard",
      },
      {
        "name": "Cardio Kickstart",
        "sweatStart": "2 min",
        "bodyType": "Full Body",
        "weightGoal": "Lose",
        "difficultyLevel": "Medium",
      },
    ];

    for (var routine in workoutRoutines) {
      await firestore.collection('workoutRoutines').add(routine);
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
      loadFavorites(), // Load favorites from SharedPreferences
    ]);
  }

  // Initialize provider with all data
  Future<void> initializeProvider() async {
    await loadCachedData();
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

      // Return the booked appointment for confirmation screen
      return true;
    } catch (e) {
      _bookingMessage = 'Failed to book appointment. Please try again.';
      _bookingAppointments.remove(appointmentId);
      notifyListeners();
      return false;
    }
  }

  // Favorite-related methods

  /// Load favorites from SharedPreferences
  Future<void> loadFavorites() async {
    try {
      List<AssessmentCardModel> favorites =
          await FavoriteService.getFavorites();
      _favoriteAssessments =
          favorites.map((assessment) => assessment.id).toSet();
      notifyListeners();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  /// Check if an assessment is favorite
  bool isFavorite(String assessmentId) {
    return _favoriteAssessments.contains(assessmentId);
  }

  /// Toggle favorite status for an assessment
  Future<void> toggleFavorite(AssessmentCardModel assessment) async {
    try {
      bool newFavoriteStatus = await FavoriteService.toggleFavorite(assessment);

      if (newFavoriteStatus) {
        _favoriteAssessments.add(assessment.id);
        _bookingMessage = '${assessment.title} added to favorites!';
      } else {
        _favoriteAssessments.remove(assessment.id);
        _bookingMessage = '${assessment.title} removed from favorites!';
      }

      notifyListeners();

      // Clear message after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        _bookingMessage = null;
        notifyListeners();
      });
    } catch (e) {
      _bookingMessage = 'Failed to update favorites. Please try again.';
      notifyListeners();
    }
  }

  /// Get all favorite assessments
  Future<List<AssessmentCardModel>> getFavoriteAssessments() async {
    try {
      return await FavoriteService.getFavorites();
    } catch (e) {
      print('Error getting favorite assessments: $e');
      return [];
    }
  }

  /// Clear all favorites
  Future<void> clearAllFavorites() async {
    try {
      await FavoriteService.clearAllFavorites();
      _favoriteAssessments.clear();
      _bookingMessage = 'All favorites cleared!';
      notifyListeners();

      // Clear message after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        _bookingMessage = null;
        notifyListeners();
      });
    } catch (e) {
      _bookingMessage = 'Failed to clear favorites. Please try again.';
      notifyListeners();
    }
  }

  /// Get appointment by ID
  AppointmentModel? getAppointmentById(String appointmentId) {
    try {
      return _appointmentCards.firstWhere(
        (appointment) => appointment.id == appointmentId,
      );
    } catch (e) {
      return null;
    }
  }
}
