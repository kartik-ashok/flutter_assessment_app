import 'package:flutter/material.dart';

class HealthRiskAssessment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Jane'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // My Assessments and My Appointments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Assessments', style: TextStyle(fontSize: 18)),
                Text(
                  'My Appointments',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Appointment Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppointmentCard(
                    label: 'Cancer 2nd Opinion', color: Colors.blue),
                AppointmentCard(
                    label: 'Physiotherapy Appointment', color: Colors.pink),
                AppointmentCard(
                    label: 'Fitness Appointment', color: Colors.orange),
              ],
            ),
            SizedBox(height: 16),

            // View All Button
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text('View all'),
              ),
            ),
            SizedBox(height: 16),

            // Challenges Section
            Text('Challenges', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            ChallengeCard(),
            SizedBox(height: 8),

            // Workout Routines Section
            Text('Workout Routines', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            WorkoutRoutineCard(),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String label;
  final Color color;

  const AppointmentCard({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Challenge!", style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Push Up 20x', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          LinearProgressIndicator(value: 0.5), // 10/20 Complete
          SizedBox(height: 8),
          Text('10/20 Complete', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class WorkoutRoutineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sweat Starter', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('Full Body', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Difficulty: Medium', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
