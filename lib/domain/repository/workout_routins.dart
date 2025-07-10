import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRoutins {
  Future<void> addWorkoutRoutinsToFirestore() async {
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

  Future<List<Map<String, dynamic>>> fetchWorkoutRoutines() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot =
        await firestore.collection('workoutRoutines').get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
