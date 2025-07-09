

import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/domain/repository/appointment_service.dart';
import 'package:flutter_assessment_app/domain/repository/assessment_cardstofirestore.dart';
import 'package:flutter_assessment_app/domain/repository/workout_routins.dart';

class AddDataButtons extends StatelessWidget {
  final AddAssessmentCardstofirestore addAssessmentCardstofirestore =
      AddAssessmentCardstofirestore();
  final AppointmentService appointmentService = AppointmentService();
  final WorkoutRoutins workoutRoutins = WorkoutRoutins();

  AddDataButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Data to Firestore"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildButton(
                context,
                icon: Icons.assessment,
                label: "Add Assessment Cards",
                onPressed: () {
                  addAssessmentCardstofirestore.addAssessmentCardsToFirestore();
                },
              ),
              const SizedBox(height: 16),
              _buildButton(
                context,
                icon: Icons.calendar_today,
                label: "Add Appointment Cards",
                onPressed: () {
                  appointmentService.addAppointmentCardsToFirestore();
                },
              ),
              const SizedBox(height: 16),
              _buildButton(
                context,
                icon: Icons.fitness_center,
                label: "Add Workout Cards",
                onPressed: () {
                  workoutRoutins.addWorkoutRoutinsToFirestore();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
