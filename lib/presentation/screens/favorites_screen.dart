import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/assets/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/assets/image_paths.dart';
import 'package:flutter_assessment_app/model/Assessment_card_model.dart';
import 'package:flutter_assessment_app/model/healthcare_service.dart';
import 'package:flutter_assessment_app/presentation/screens/health_risk_assessment.dart';
import 'package:flutter_assessment_app/provider/provider.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final double cardRadius = ResponsiveSize.width(12);
  List<String> assessmentCards = [
    ImagePaths.sitRelax,
    ImagePaths.halfSquats,
  ];

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

  Widget favoriteAssessmentCard({
    required int index,
    required AssessmentCardModel assessment,
    required VoidCallback onRemoveFavorite,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveSize.height(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
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
                    topLeft: Radius.circular(cardRadius),
                    bottomLeft: Radius.circular(cardRadius),
                  ),
                  gradient: index % 2 == 0
                      ? AppColors.orangeGradientone
                      : AppColors.greenGradientTwo,
                ),
                child: Hero(
                  tag: 'favorite_assessment_image_${assessment.id}_$index',
                  child: Image.asset(
                    assessmentCards[index % 2],
                    width: ResponsiveSize.width(99),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: ResponsiveSize.width(99),
                      height: ResponsiveSize.height(99),
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
                      Text(assessment.title,
                          style: AppTextStyles.size24w600Blue
                              .copyWith(fontSize: ResponsiveSize.width(14))),
                      SizedBox(height: ResponsiveSize.height(4)),
                      Text(assessment.description,
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
          // Remove favorite button positioned in top-right corner
          Positioned(
            top: ResponsiveSize.height(8),
            right: ResponsiveSize.width(8),
            child: GestureDetector(
              onTap: onRemoveFavorite,
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
                  Icons.favorite,
                  color: Colors.red,
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
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: const Text(
          'Favorite Assessments',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: ResponsiveSize.width(2),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          Consumer<AssessmentCardProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.clear_all),
                onPressed: provider.favoriteAssessments.isNotEmpty
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Clear All Favorites'),
                            content: const Text(
                                'Are you sure you want to remove all favorites?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  provider.clearAllFavorites();
                                  Navigator.pop(context);
                                },
                                child: const Text('Clear All'),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                tooltip: 'Clear all favorites',
              );
            },
          ),
        ],
      ),
      body: Consumer<AssessmentCardProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<AssessmentCardModel>>(
            future: provider.getFavoriteAssessments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: ResponsiveSize.width(64),
                        color: Colors.grey,
                      ),
                      SizedBox(height: ResponsiveSize.height(16)),
                      Text(
                        'Error loading favorites',
                        style: TextStyle(
                          fontSize: ResponsiveSize.width(18),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final favorites = snapshot.data ?? [];

              if (favorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: ResponsiveSize.width(64),
                        color: Colors.grey,
                      ),
                      SizedBox(height: ResponsiveSize.height(16)),
                      Text(
                        'No favorite assessments yet',
                        style: TextStyle(
                          fontSize: ResponsiveSize.width(18),
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.height(8)),
                      Text(
                        'Tap the heart icon on assessments to add them here',
                        style: TextStyle(
                          fontSize: ResponsiveSize.width(14),
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(ResponsiveSize.width(16)),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final assessment = favorites[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: HealthRiskAssessment(
                            imageUrl:
                                assessmentCards[index % assessmentCards.length],
                            title: assessment.title,
                            description: assessment.description,
                            heroTag:
                                'favorite_assessment_image_${assessment.id}_$index',
                          ),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: favoriteAssessmentCard(
                      index: index,
                      assessment: assessment,
                      onRemoveFavorite: () {
                        provider.toggleFavorite(assessment);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
