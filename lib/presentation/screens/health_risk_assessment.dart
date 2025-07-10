import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/ASSETS/app_colors.dart';
import 'package:flutter_assessment_app/assets/apptext_styles.dart';
import 'package:flutter_assessment_app/assets/image_paths.dart';
import 'package:flutter_assessment_app/utils/responsive_utils.dart';

class HealthRiskAssessment extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String heroTag;

  const HealthRiskAssessment({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topHeight = ResponsiveSize.height(320);

    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              height: topHeight,
              width: double.infinity,
              padding: EdgeInsets.all(ResponsiveSize.width(16)),
              color: AppColors.lightGreen,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image on the left

                  // Column with back button, title, and time
                  Expanded(
                    flex: 3, // Adjust for content size
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.black),
                            onPressed: () => Navigator.of(context).maybePop(),
                          ),
                        ),
                        SizedBox(height: ResponsiveSize.height(6)),
                        Text(
                          (this.title),
                          style: AppTextStyles.size24w600Blue,
                        ),
                        SizedBox(height: ResponsiveSize.height(8)),
                        Container(
                          width: ResponsiveSize.width(65),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ResponsiveSize.width(5)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.black54),
                              SizedBox(width: ResponsiveSize.width(4)),
                              Text(
                                '4 min',
                                style: AppTextStyles.size10w400Grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: ResponsiveSize.width(
                          8)), // spacing between image and text

                  Expanded(
                    flex: 3, // Adjust for image size
                    child: Hero(
                      tag: heroTag, // Use the same tag as the source image
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: ResponsiveSize.width(100),
                          height: ResponsiveSize.height(100),
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Text('Image\nUnavailable',
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Scrollable Section
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveSize.width(8),
                    vertical: ResponsiveSize.height(8)),
                decoration: BoxDecoration(
                  color: Colors.white, // Changed to red
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                          ResponsiveSize.width(24))), // Curved border
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                      ResponsiveSize.width(16),
                      ResponsiveSize.height(20),
                      ResponsiveSize.width(16),
                      ResponsiveSize.height(40)),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('What do you get ?',
                          style: AppTextStyles.size24w600Blue
                              .copyWith(fontSize: ResponsiveSize.width(15))),
                      SizedBox(height: ResponsiveSize.height(12)),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconLabelCard(
                            iconUrl: ImagePaths.heart,
                            label: 'Key Body Vitals',
                          ),
                          IconLabelCard(
                            iconUrl: ImagePaths.posture,
                            label: 'Posture Analysis',
                          ),
                          IconLabelCard(
                            iconUrl: ImagePaths.body,
                            label: 'Body Composition',
                          ),
                          IconLabelCard(
                            iconUrl: ImagePaths.report,
                            label: 'Instant Reports',
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveSize.height(12)),
                      Text('How we do it?',
                          style: AppTextStyles.size24w600Blue
                              .copyWith(fontSize: ResponsiveSize.width(15))),
                      SizedBox(height: ResponsiveSize.height(12)),
                      Center(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(ResponsiveSize.width(16)),
                          child: // Parent container (main container)
                              SizedBox(
                            height: ResponsiveSize.height(
                                180), // height of the card
                            child: Stack(
                              clipBehavior:
                                  Clip.none, // Allows child to overflow
                              // allows overflow outside bounds
                              children: [
                                // 1. Exercise image - background
                                Container(
                                  width: double.infinity,
                                  height: ResponsiveSize.height(180),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ResponsiveSize.width(16)),
                                    image: DecorationImage(
                                      image: AssetImage(ImagePaths.exercise),
                                      fit: BoxFit.cover,
                                      onError: (error, stackTrace) {},
                                    ),
                                  ),
                                ),
                                // 2. Optional transparent overlay
                                Container(
                                  width: double.infinity,
                                  height: ResponsiveSize.height(180),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                        ResponsiveSize.width(16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.height(24)),
                      Container(
                        padding: EdgeInsets.all(ResponsiveSize.width(12)),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 218, 232, 226),
                          borderRadius:
                              BorderRadius.circular(ResponsiveSize.width(12)),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                                width: ResponsiveSize.width(13),
                                height: ResponsiveSize.height(15),
                                ImagePaths.ic_security),
                            SizedBox(width: ResponsiveSize.width(10)),
                            Flexible(
                              child: Text(
                                'We do not store or share your personal data',
                                style: TextStyle(
                                  fontSize: ResponsiveSize.width(14),
                                  color: const Color(0xFF27AE60),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.height(16)),
                      const InstructionList(
                        instructions: [
                          "Ensure that you are in a well-lit space",
                          "Allow camera access and place your device against a stable object or wall",
                          "Avoid wearing baggy clothes",
                          "Make sure you exercise as per the instruction provided by the trainer",
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Icon Card Widget
class IconLabelCard extends StatelessWidget {
  final String iconUrl;
  final String label;

  const IconLabelCard({Key? key, required this.iconUrl, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: ResponsiveSize.width(64),
            height: ResponsiveSize.height(64),
            padding: EdgeInsets.all(ResponsiveSize.width(6)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                  color: Colors.grey.shade300, width: ResponsiveSize.width(1)),
            ),
            child: ClipOval(
              child: Image.asset(
                iconUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error_outline, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: ResponsiveSize.height(8)),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.size24w600Blue.copyWith(
                fontSize: ResponsiveSize.width(8), color: AppColors.black),
          ),
        ],
      ),
    );
  }
}

// Instruction List
class InstructionList extends StatelessWidget {
  final List<String> instructions;

  const InstructionList({Key? key, required this.instructions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        instructions.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: ResponsiveSize.height(8)),
          child: Text(
            '${index + 1}. ${instructions[index]}',
            style:
                AppTextStyles.size12w400Grey.copyWith(color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
