import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRoutins {
  Future<void> addWorkoutRoutinsToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Map<String, dynamic> workoutRoutines = {
      "name": "Full Body Burner",
      "sweatStart": "5 min",
      "bodyType": "Full Body",
      "weightGoal": "Lose",
      "difficultyLevel": "Medium",
    };

    await firestore.collection('workoutRoutines').add(workoutRoutines);
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
