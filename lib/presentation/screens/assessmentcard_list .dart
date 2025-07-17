import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/ASSETS/apptext_styles.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/image_paths.dart';
import 'package:flutter_assessment_app/model/Assessment_card_model.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/presentation/screens/health_risk_assessment.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:provider/provider.dart';

class AssessmentCardList extends StatefulWidget {
  final List<AssessmentCardModel> appointments;

  const AssessmentCardList({super.key, required this.appointments});

  @override
  State<AssessmentCardList> createState() => _AssessmentCardListState();
}

class _AssessmentCardListState extends State<AssessmentCardList> {
  Widget bluePlayIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff2a70f4),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveSize.width(4)),
        child: Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: ResponsiveSize.width(18),
        ),
      ),
    );
  }

  final List<String> assessmentCards = [
    ImagePaths.sitRelax,
    ImagePaths.halfSquats,
  ];

  Widget assessmentCard({
    required int index,
    required String imageUrl,
    required String title,
    required String description,
    required AssessmentCardModel appointment,
    required String assessmentId,
    required VoidCallback onFavoriteToggle,
    required bool isFavorite,
    // VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveSize.height(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveSize.width(12)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffeeeeee),
            blurRadius: ResponsiveSize.width(6),
            offset: Offset(0, ResponsiveSize.height(3)),
          )
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Image with rounded left corners
              Container(
                padding: EdgeInsets.all(ResponsiveSize.width(10)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ResponsiveSize.width(12)),
                    bottomLeft: Radius.circular(ResponsiveSize.width(12)),
                  ),
                  gradient: index % 2 == 0
                      ? AppColors.orangeGradientone
                      : AppColors.greenGradientTwo,
                ),
                child: Hero(
                  tag:
                      'assessment_image_${assessmentId}_$index', // Unique tag using ID and index
                  child: Image.asset(
                    assessmentCards[index % 2],
                    width: ResponsiveSize.width(99),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: ResponsiveSize.width(100),
                      height: ResponsiveSize.height(116),
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: Icon(Icons.broken_image,
                          color: Colors.grey, size: ResponsiveSize.width(40)),
                    ),
                  ),
                ),
              ),
              // Text content and start play icon
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      ResponsiveSize.width(14),
                      ResponsiveSize.height(14),
                      ResponsiveSize.width(14),
                      ResponsiveSize.height(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: AppTextStyles.size24w600Blue
                              .copyWith(fontSize: ResponsiveSize.width(14))),
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
                          SizedBox(width: ResponsiveSize.width(8)),
                          Text(
                            'Start',
                            style: AppTextStyles.size14w500Blue.copyWith(
                                fontSize: ResponsiveSize.width(14),
                                color: AppColors.primaryBlue),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          // Favorite button positioned in top-right corner
          Positioned(
            top: ResponsiveSize.height(8),
            right: ResponsiveSize.width(8),
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: Container(
                padding: EdgeInsets.all(ResponsiveSize.width(6)),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: ResponsiveSize.width(4),
                      offset: Offset(0, ResponsiveSize.height(2)),
                    ),
                  ],
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: ResponsiveSize.width(20),
                ),
              ),
            ),
          ),
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
      body: Consumer<AssessmentCardProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.appointments.length,
            itemBuilder: (context, index) {
              final appointment = widget.appointments[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return HealthRiskAssessment(
                          imageUrl:
                              assessmentCards[index % assessmentCards.length],
                          title: appointment.title,
                          description: appointment.description,
                          heroTag:
                              'assessment_image_${appointment.id}_$index', // Pass the hero tag with ID and index
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
                  description:
                      appointment.description, // Ensure this field exists
                  appointment: appointment,
                  assessmentId: appointment.id,
                  isFavorite: provider.isFavorite(appointment.id),
                  onFavoriteToggle: () {
                    provider.toggleFavorite(appointment);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
