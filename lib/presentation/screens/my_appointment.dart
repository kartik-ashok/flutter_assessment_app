import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/assets/image_paths.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:provider/provider.dart';

class MyAppointment extends StatefulWidget {
  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  bool showAll = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AssessmentCardProvider>(context, listen: false)
        .fetchAppointmentCards();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentCardProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 16),

          // Appointments Grid
          // const Text(
          //   'My Appointments',
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w700,
          //     color: Colors.black87,
          //   ),
          // ),
          // const SizedBox(height: 16),
          if (provider.isLoading) ...[
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ] else if (provider.cards.isEmpty) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'No assessments found',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add Sample Cards'),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3 / 2,
              ),
              itemCount: showAll
                  ? provider.appointmentCard.length
                  : 3, // Reduced count for better layout
              itemBuilder: (context, index) {
                final appointments = [
                  {'logo': ImagePaths.cancer, 'color': Color(0xffC6D9FF)},
                  {'logo': ImagePaths.therapy, 'color': Color(0xffE9C6FF)},
                  {'logo': ImagePaths.dambles, 'color': Color(0xffFFD4C6)},
                ];

                final appointment = appointments[index % appointments.length];
                return AppointmentCard(
                  logo: appointment['logo'] as String,
                  color: appointment['color'] as Color,
                  label: provider.appointmentCard[index].name +
                      provider.appointmentCard[index].type,
                );
              },
            ),
          ],
          const SizedBox(height: 16),

          // View All Button
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showAll = !showAll;
                });
                // Implement View all functionality
                // Implement view all appointments
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2a70f4),
                minimumSize: const Size(90, 28),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'View all',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Challenges Section
          const Text(
            'Challenges',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          challengeCard(),

          const SizedBox(height: 24),

          // Workout Routines Section
          sectionHeader(
            title: 'Workout Routines',
            onViewAll: () {
              // Implement Workout Routines View All
            },
          ),

          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 12),
                  child: workoutCard(
                    imageUrl:
                        'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/ac2a53ba-d701-48af-a851-3d6e37454e46.png',
                    title: 'Sweat Starter',
                    subtitle: 'Full Body',
                    tagText: 'Lose Weight',
                    tagColor: const Color(0xff71aadf),
                    difficulty: 'Medium',
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String logo;
  final Color color;
  final String label;

  const AppointmentCard({
    super.key,
    required this.logo,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(5),
                color: AppColors.white,
                child: Image.asset(
                  logo,
                  fit: BoxFit.contain,
                ),
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.size24w600Blue.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class AppointmentCard extends StatelessWidget {
//   final String logo;
//   final Color color;
//   final String label;

//   const AppointmentCard({
//     super.key,
//     required this.logo,
//     required this.color,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(30),
//               child: Container(
//                 padding: const EdgeInsets.all(5),
//                 color: AppColors.white,
//                 child: Image.asset(
//                   logo,
//                   fit: BoxFit.fill,
//                 ),
//                 height: 50,
//                 width: 50,
//               ),
//             ),
//             Center(
//               child: Text(label,
//                   textAlign: TextAlign.center,
//                   style: AppTextStyles.size24w600Blue.copyWith(fontSize: 14)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Challenge card widget
Widget challengeCard() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xffdff6e7),
      borderRadius: BorderRadius.circular(14),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    margin: const EdgeInsets.only(bottom: 14),
    // height: 129,
    // padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        // Left text column
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Challenge!",
                  style: AppTextStyles.size12w500BemeraldGreen),
              const SizedBox(height: 8),
              Container(
                // height: 16,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.emeraldGreen.withOpacity(0.1),
                ),
                child:
                    Text('Push Up 20x', style: AppTextStyles.size10w500white),
              ),
              const SizedBox(height: 12),
              // Progress bar with text below
              Stack(
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x44707070),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    // 50% progress - 10/20 complete
                    final width = constraints.maxWidth * 0.5;
                    return Container(
                      height: 8,
                      width: width,
                      decoration: BoxDecoration(
                        color: const Color(0xff23742d),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                '10/20 Complete',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xff23742d),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff23742d),
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Continue',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff23742d),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        // Right image of person doing push-ups
        Expanded(
          flex: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              ImagePaths.pushUp,
              height: 85,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 129,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image,
                    color: Colors.grey, size: 40),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

// Workout routine card widget
Widget workoutCard({
  required String imageUrl,
  required String title,
  required String subtitle,
  required String tagText,
  required Color tagColor,
  required String difficulty,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        BoxShadow(
          color: Color(0xffeeeeee),
          blurRadius: 6,
          offset: Offset(0, 3),
        )
      ],
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14),
            bottomLeft: Radius.circular(14),
          ),
          child: Image.network(
            imageUrl,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 90,
              height: 90,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child:
                  const Icon(Icons.broken_image, color: Colors.grey, size: 40),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xff505050),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                        color: tagColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tagText,
                        style: TextStyle(
                          fontSize: 12,
                          color: tagColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'Difficulty : $difficulty',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: difficulty.toLowerCase() == 'medium'
                            ? Colors.orange
                            : Colors.grey[700],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget sectionHeader({required String title, required VoidCallback onViewAll}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: const Row(
            children: [
              Text(
                'View All',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xff2a70f4),
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Color(0xff2a70f4),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class WorkoutRoutineCard extends StatelessWidget {
  const WorkoutRoutineCard({super.key});

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
