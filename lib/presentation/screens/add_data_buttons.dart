// import 'package:flutter/material.dart';
// import 'package:flutter_assessment_app/domain/repository/appointment_service.dart';
// import 'package:flutter_assessment_app/domain/repository/assessment_cardstofirestore.dart';
// import 'package:flutter_assessment_app/domain/repository/workout_routins.dart';

// class AddDataButtons extends StatelessWidget {
//   final AddAssessmentCardstofirestore addAssessmentCardstofirestore =
//       AddAssessmentCardstofirestore();
//   final AppointmentService appointmentService = AppointmentService();
//   final WorkoutRoutins workoutRoutins = WorkoutRoutins();

//   AddDataButtons({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Upload Data to Firestore"),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildButton(
//                 context,
//                 icon: Icons.assessment,
//                 label: "Add Assessment Cards",
//                 onPressed: () {
//                   addAssessmentCardstofirestore.addAssessmentCardsToFirestore();
//                 },
//               ),
//               const SizedBox(height: 16),
//               _buildButton(
//                 context,
//                 icon: Icons.calendar_today,
//                 label: "Add Appointment Cards",
//                 onPressed: () {
//                   appointmentService.addAppointmentCardsToFirestore();
//                 },
//               ),
//               const SizedBox(height: 16),
//               _buildButton(
//                 context,
//                 icon: Icons.fitness_center,
//                 label: "Add Workout Cards",
//                 onPressed: () {
//                   workoutRoutins.addWorkoutRoutinsToFirestore();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(BuildContext context,
//       {required IconData icon,
//       required String label,
//       required VoidCallback onPressed}) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: onPressed,
//         icon: Icon(icon, size: 24),
//         label: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12.0),
//           child: Text(label, style: const TextStyle(fontSize: 16)),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.deepPurple,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Upload Data to Firestore"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildUploadCard(
                context,
                icon: Icons.assessment,
                title: "Add Assessment Cards",
                subtitle: "Upload health assessment data",
                onTap: () {
                  addAssessmentCardstofirestore.addAssessmentCardsToFirestore();
                  _showSnack(context, "Assessment Cards Uploaded");
                },
              ),
              const SizedBox(height: 16),
              _buildUploadCard(
                context,
                icon: Icons.calendar_today,
                title: "Add Appointment Cards",
                subtitle: "Upload appointment details",
                onTap: () {
                  appointmentService.addAppointmentCardsToFirestore();
                  _showSnack(context, "Appointment Cards Uploaded");
                },
              ),
              const SizedBox(height: 16),
              _buildUploadCard(
                context,
                icon: Icons.fitness_center,
                title: "Add Workout Cards",
                subtitle: "Upload workout routines",
                onTap: () {
                  workoutRoutins.addWorkoutRoutinsToFirestore();
                  _showSnack(context, "Workout Routines Uploaded");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.deepPurple.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                child: Icon(icon, color: Colors.deepPurple, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 18, color: Colors.deepPurple),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
