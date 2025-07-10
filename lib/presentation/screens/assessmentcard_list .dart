import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/ASSETS/apptext_styles.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/image_paths.dart';
import 'package:flutter_assessment_app/model/Assessment_card_model.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/presentation/screens/health_risk_assessment.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';

class AssessmentCardList extends StatelessWidget {
  final List<AssessmentCardModel> appointments;

  AssessmentCardList({super.key, required this.appointments});

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

  Widget assessmentCard({
    required int index,
    required String imageUrl,
    required String title,
    required String description,
    required AssessmentCardModel appointment,

    // VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              gradient: index % 2 == 0
                  ? AppColors.orangeGradientone
                  : AppColors.greenGradientTwo,
            ),
            child: Hero(
              tag: 'assessment_image_$title', // Unique tag for each card
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.primaryBlue,
        title: Text(
          "Assessment Cards",
          style: AppTextStyles.size24w400Grey.copyWith(color: AppColors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return HealthRiskAssessment(
                      imageUrl: assessmentCards[index % assessmentCards.length],
                      title: appointment.title,
                      description: appointment.description,
                      heroTag:
                          'assessment_image_${appointment.title}', // Pass the hero tag
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 600),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Fade transition to complement the Hero animation
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: assessmentCard(
              index: index,
              imageUrl: appointment.imageUrl, // Ensure this field exists
              title: appointment.title, // Ensure this field exists
              description: appointment.description, // Ensure this field exists
              appointment: appointment,
            ),
          );
        },
      ),
    );
  }
}
