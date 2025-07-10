import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/assets/image_paths.dart';
import 'package:flutter_assessment_app/domain/repository/appointment_service.dart';
import 'package:flutter_assessment_app/presentation/screens/list_of_appointments.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MyAppointment extends StatefulWidget {
  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  bool showAll = false;

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure fetch calls happen after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<AssessmentCardProvider>(context, listen: false);
      provider.fetchAppointmentCards();
      provider.fetchWorkoutRoutines();
    });
  }

  List<String> routineImags = [
    ImagePaths.squats,
    ImagePaths.halfSquats,
  ];

  final AppointmentService appointmentService = AppointmentService();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentCardProvider>(context);
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: AppColors.primaryBlue,
      onRefresh: () {
        return appointmentService.cacheAppointmentCards();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (provider.isLoading) ...[
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 280,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                itemCount: provider.appointmentCard.length <= 3
                    ? provider.appointmentCard.length
                    : 3,
                // showAll
                //     ? provider.appointmentCard.length
                //     : 3, // Reduced count for better layout
                itemBuilder: (context, index) {
                  final appointments = [
                    {
                      'logo': ImagePaths.cancer,
                      'color': const Color(0xffC6D9FF)
                    },
                    {
                      'logo': ImagePaths.therapy,
                      'color': const Color(0xffE9C6FF)
                    },
                    {
                      'logo': ImagePaths.dambles,
                      'color': const Color(0xffFFD4C6)
                    },
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
                  // use pageTransion

                  Navigator.push(
                    context,
                    PageTransition(
                      child: ListOfAppointments(
                        appointments: provider.appointmentCard,
                      ),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
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

            sectionHeader(
              title: 'Workout Routines',
              onViewAll: () {},
            ),

            SizedBox(
              height: ResponsiveSize.height(200),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.workoutRoutins.length,
                itemBuilder: (context, index) {
                  if (provider.isLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 280,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }
                  if (provider.workoutRoutins.isEmpty) {
                    return Center(
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
                    );
                  }

                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: workoutCard(
                      imageUrl: routineImags[index % routineImags.length],
                      title: provider.workoutRoutins[index].name,
                      subtitle: provider.workoutRoutins[index].bodyType,
                      tagText: provider.workoutRoutins[index].weightGoal,
                      tagColor: const Color(0xff71aadf),
                      difficulty:
                          provider.workoutRoutins[index].difficultyLevel,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String logo;
  final Color color;
  final String label;

  AppointmentCard({
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
                height: ResponsiveSize.height(40),
                width: ResponsiveSize.width(40),
              ),
            ),
            SizedBox(height: ResponsiveSize.height(2)),
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

// Challenge card widget
Widget challengeCard() {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.limeGreen,
      borderRadius: BorderRadius.circular(14),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    margin: const EdgeInsets.only(bottom: 14),
    child: Row(
      children: [
        // Left text column
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Challenge!",
                  style: AppTextStyles.size12w500BemeraldGreen),
              SizedBox(height: ResponsiveSize.height(8)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.emeraldGreen,
                ),
                child:
                    Text('Push Up 20x', style: AppTextStyles.size10w500white),
              ),
              SizedBox(height: ResponsiveSize.height(12)),
              Stack(
                children: [
                  Container(
                    height: ResponsiveSize.height(8),
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
                      height: ResponsiveSize.height(8),
                      width: width,
                      decoration: BoxDecoration(
                        color: AppColors.primarypink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: ResponsiveSize.height(8)),
              Row(
                children: [
                  Text(
                    '10/20 ',
                    style: AppTextStyles.size14w700Black.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Complete',
                    style: AppTextStyles.size14w700Black
                        .copyWith(fontSize: 12, color: AppColors.secondaryGrey),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveSize.height(4)),
              Container(
                width: 120,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
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
                        color: AppColors.primaryBlue,
                      ),
                    )
                  ],
                ),
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
              height: ResponsiveSize.height(80),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: ResponsiveSize.height(129),
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
    width: ResponsiveSize.width(250),
    height: ResponsiveSize.height(112),
    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.primaryGrey, width: 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: ResponsiveSize.width(107),
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: AppColors.orangeGradientone,
          ),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: ResponsiveSize.width(90),
              height: ResponsiveSize.height(90),
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
                  style: AppTextStyles.size14w500Blue
                      .copyWith(color: AppColors.black),
                ),
                SizedBox(height: ResponsiveSize.height(4)),
                Text(subtitle,
                    style: AppTextStyles.size10w500Blue.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(height: ResponsiveSize.height(4)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryGrey, width: 1),
                  ),
                  child: Text(tagText,
                      style: AppTextStyles.size10w500Blue
                          .copyWith(color: AppColors.primaryBlue)),
                ),
                SizedBox(height: ResponsiveSize.height(4)),
                Row(
                  children: [
                    Text(
                      'Difficulty :',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.secondaryGrey),
                    ),
                    Text(
                      '$difficulty',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.primarypink),
                    ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sweat Starter', style: TextStyle(fontSize: 18)),
          SizedBox(height: ResponsiveSize.height(8)),
          const Text('Full Body', style: TextStyle(fontSize: 16)),
          SizedBox(height: ResponsiveSize.height(8)),
          const Text('Difficulty: Medium', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
