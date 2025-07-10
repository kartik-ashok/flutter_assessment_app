import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/ASSETS/apptext_styles.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/image_paths.dart';
import 'package:flutter_assessment_app/domain/repository/assessment_cardstofirestore.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/presentation/screens/health_risk_assessment.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MyAssessment extends StatefulWidget {
  const MyAssessment({super.key});

  @override
  State<MyAssessment> createState() => _MyAssessmentState();
}

class _MyAssessmentState extends State<MyAssessment> {
  final double cardRadius = 12.0;
  // bool showAll = false;

  AddAssessmentCardstofirestore addAssessmentCardstofirestore =
      AddAssessmentCardstofirestore();

  Widget bluePlayIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff2a70f4),
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
    );
  }

  List<String> assessmentCards = [
    ImagePaths.sitRelax,
    ImagePaths.halfSquats,
  ];

  // Assessment card widget
  Widget assessmentCard({
    required int index,
    required String imageUrl,
    required String title,
    required String description,
    required AppointmentModel appointment,

    // VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffeeeeee),
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Image with rounded left corners
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(cardRadius),
                bottomLeft: Radius.circular(cardRadius),
              ),
              gradient: index % 2 == 0
                  ? AppColors.orangeGradientone
                  : AppColors.greenGradientTwo,
            ),
            child: Image.asset(
              assessmentCards[index % 2],
              width: 99,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: ResponsiveSize.width(100),
                height: ResponsiveSize.height(116),
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image,
                    color: Colors.grey, size: 40),
              ),
            ),
          ),
          // Text content and start play icon
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          AppTextStyles.size24w600Blue.copyWith(fontSize: 14)),
                  SizedBox(height: ResponsiveSize.height(4)),
                  Text(description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTextStyles.size10w400Grey
                          .copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(height: ResponsiveSize.height(4)),
                  Row(
                    children: [
                      bluePlayIcon(),
                      const SizedBox(width: 8),
                      Text(
                        'Start',
                        style: AppTextStyles.size14w500Blue.copyWith(
                            fontSize: 14, color: AppColors.primaryBlue),
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

  Widget sectionHeader(
      {required String title, required VoidCallback onViewAll}) {
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

  // Challenge card widget
  Widget challengeCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.limeGreen,
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
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's Challenge!",
                    style: AppTextStyles.size12w500BemeraldGreen),
                SizedBox(height: ResponsiveSize.height(8)),
                Container(
                  // height: 16,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.emeraldGreen,
                  ),
                  child:
                      Text('Push Up 20x', style: AppTextStyles.size10w500white),
                ),
                SizedBox(height: ResponsiveSize.height(12)),
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
                      style: AppTextStyles.size14w700Black.copyWith(
                          fontSize: 12, color: AppColors.secondaryGrey),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveSize.height(4)),
                Container(
                  width: 120,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
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
                child: const Icon(Icons.broken_image,
                    color: Colors.grey, size: 40),
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
                    width: ResponsiveSize.width(70),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: AppColors.primaryGrey, width: 1),
                    ),
                    child: Center(
                      child: Text(tagText,
                          style: AppTextStyles.size10w500Blue
                              .copyWith(color: AppColors.primaryBlue)),
                    ),
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
                        overflow: TextOverflow.ellipsis,
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

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure fetch calls happen after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<AssessmentCardProvider>(context, listen: false);
      provider.fetchCards();
      provider.fetchAppointmentCards();
      provider.fetchWorkoutRoutines();
    });
  }

  List<String> routineImags = [
    ImagePaths.squats,
    ImagePaths.halfSquats,
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentCardProvider>(context);

    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primaryBlue,
        onRefresh: () {
          return addAssessmentCardstofirestore.cacheAssessmentCards();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Assessment cards section
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
                              SizedBox(height: ResponsiveSize.height(12)),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Add Sample Cards'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.cards.length,
                        itemBuilder: (context, index) {
                          final card = provider.cards[index];

                          // Safe access to appointment cards with fallback
                          AppointmentModel appointment;
                          if (provider.appointmentCard.isNotEmpty) {
                            appointment = provider.appointmentCard[
                                index % provider.appointmentCard.length];
                          } else {
                            // Fallback appointment when list is empty
                            appointment = AppointmentModel(
                              docId: 'default',
                              id: 'default',
                              name: 'Health Assessment',
                              type: 'Consultation',
                              doctorName: 'Dr. Smith',
                              doctorSpeciality: 'General',
                              date: '2025-07-12',
                              time: '10:00 AM',
                              duration: '30 mins',
                              location: 'Online',
                              isBooked: false,
                              price: 0,
                              description: 'General health assessment',
                              imageUrl: '',
                            );
                          }

                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return HealthRiskAssessment(
                                    imageUrl: assessmentCards[
                                        index % assessmentCards.length],
                                    title: card.title,
                                    description: card.description,
                                  );
                                },
                              ));
                            },
                            child: assessmentCard(
                              index: index,
                              imageUrl: card.imageUrl,
                              title: card.title,
                              description: card.description,
                              appointment: appointment,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: ResponsiveSize.height(16)),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // showAll = !showAll;
                            });
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
                    ],
                  ],
                ),
              ),

              SizedBox(height: ResponsiveSize.height(24)),

              // Challenges Section
              sectionHeader(
                title: 'Challenges',
                onViewAll: () {
                  // Implement Challenges View All
                },
              ),
              challengeCard(),

              // SizedBox(height: ResponsiveSize.height(24)),

              // Workout Routines Section
              sectionHeader(
                title: 'Workout Routines',
                onViewAll: () {
                  // Implement Workout Routines View All
                },
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
      ),
    );
  }
}
