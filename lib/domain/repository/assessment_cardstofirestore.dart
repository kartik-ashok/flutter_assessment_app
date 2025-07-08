import 'package:cloud_firestore/cloud_firestore.dart';

class AddAssessmentCardstofirestore {
  Future<void> addAssessmentCardsToFirestore() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<Map<String, dynamic>> assessmentCards = [
      {
        'imageUrl':
            'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/5dbb5706-a698-444c-8024-414e2908e507.png',
        'title': 'Health Risk Assessment',
        'description':
            'Identify And Mitigate Health Risks With Precise, Proactive Assessments',
      },
      {
        'imageUrl': 'https://placehold.co/600x400?text=Second',
        'title': 'Posture Analysis',
        'description': 'Analyze and improve your posture effectively',
      },
      {
        'imageUrl': 'https://placehold.co/600x400?text=Third',
        'title': 'Body Composition',
        'description': 'Understand your body metrics in detail',
      },
    ];

    for (var card in assessmentCards) {
      await firestore.collection('assessmentCards').add(card);
    }
  }

  Future<List<Map<String, dynamic>>> fetchAssessmentCards() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot =
        await firestore.collection('assessmentCards').get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
