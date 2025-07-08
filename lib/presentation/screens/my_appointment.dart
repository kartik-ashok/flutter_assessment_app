import 'package:flutter/material.dart';

class MyAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyAppointment');
    return Scaffold(
      // appBar: const GreetingAppBar(name: 'Jane'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 10.0, // Optional spacing between columns
                  mainAxisSpacing: 10.0, // Optional spacing between rows
                  childAspectRatio: 3 / 2, // Optional: width / height ratio
                ),
                itemCount: 10, // Set the number of items
                itemBuilder: (context, index) {
                  return const AppointmentCard(
                    label: 'Cancer 2nd Opinion',
                    color: Colors.red,
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // View All Button
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: const Text('View all'),
              ),
            ),
            const SizedBox(height: 16),

            // Challenges Section
            const Text('Challenges', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            ChallengeCard(),
            const SizedBox(height: 8),

            // Workout Routines Section
            const Text('Workout Routines', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
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
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's Challenge!", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          const Text('Push Up 20x', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          const LinearProgressIndicator(value: 0.5), // 10/20 Complete
          const SizedBox(height: 8),
          const Text('10/20 Complete', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Continue'),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
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
