import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/domain/repository/appointment_service.dart';
import 'package:flutter_assessment_app/domain/repository/assessment_cardstofirestore.dart';
import 'package:flutter_assessment_app/presentation/screens/my_appointment.dart';

class AddDataButtons extends StatelessWidget {
  AddAssessmentCardstofirestore addAssessmentCardstofirestore =
      AddAssessmentCardstofirestore();
  AppointmentService appointmentService = AppointmentService();

  AddDataButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                addAssessmentCardstofirestore.addAssessmentCardsToFirestore();
              },
              child: Text("add assessment cards")),
          ElevatedButton(
              onPressed: () {
                appointmentService.addAppointmentCardsToFirestore();
              },
              child: Text("add appointment cards"))
        ],
      ),
    );
  }
}
