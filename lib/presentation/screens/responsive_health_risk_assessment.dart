// import 'package:flutter/material.dart';
// import 'package:flutter_assessment_app/ASSETS/app_colors.dart';
// import '../../core/theme/app_colors.dart';
// import '../../core/theme/app_text_styles.dart';
// import '../../core/constants/app_constants.dart';
// import '../../core/utils/responsive_utils.dart';
// import '../widgets/common/responsive_builder.dart';
// import '../widgets/common/app_button.dart';

// class ResponsiveHealthRiskAssessment extends StatelessWidget {
//   const ResponsiveHealthRiskAssessment({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.darkGreen,
//       body: SafeArea(
//         child: ResponsiveBuilder(
//           mobile: _buildMobileLayout(context),
//           tablet: _buildTabletLayout(context),
//           desktop: _buildDesktopLayout(context),
//         ),
//       ),
//     );
//   }

//   Widget _buildMobileLayout(BuildContext context) {
//     return CustomScrollView(
//       physics: const BouncingScrollPhysics(),
//       slivers: [
//         _buildSliverAppBar(context),
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: _buildContent(context),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTabletLayout(BuildContext context) {
//     return CustomScrollView(
//       physics: const BouncingScrollPhysics(),
//       slivers: [
//         _buildSliverAppBar(context, height: 280),
//         SliverToBoxAdapter(
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
//             child: _buildContent(context),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDesktopLayout(BuildContext context) {
//     return Row(
//       children: [
//         // Left side - Header content
//         Expanded(
//           flex: 2,
//           child: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFFFF6B6B), Color(0xFFEE5A52)],
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(40.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildBackButton(context),
//                   const SizedBox(height: 40),
//                   _buildHeaderContent(context),
//                   const Spacer(),
//                   _buildHeaderImage(),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // Right side - Content
//         Expanded(
//           flex: 3,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(40.0),
//             child: _buildContent(context),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSliverAppBar(BuildContext context, {double height = 320}) {
//     return SliverAppBar(
//       expandedHeight: height,
//       pinned: true,
//       backgroundColor: Colors.transparent,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFFFF6B6B), Color(0xFFEE5A52)],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),
//                 _buildHeaderContent(context),
//                 const Spacer(),
//                 _buildHeaderImage(),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//       leading: _buildBackButton(context),
//     );
//   }

//   Widget _buildBackButton(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back, color: Colors.white),
//       onPressed: () => Navigator.of(context).pop(),
//     );
//   }

//   Widget _buildHeaderContent(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Health Risk\nAssessment',
//           style: ResponsiveUtils.getDeviceType(context) == DeviceType.desktop
//               ? AppTextStyles.displaySmall.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 )
//               : AppTextStyles.headlineMedium.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             const Icon(Icons.access_time, size: 16, color: Colors.white70),
//             const SizedBox(width: 8),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: Text(
//                 '4 min',
//                 style: AppTextStyles.labelMedium.copyWith(
//                   color: Colors.black87,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildHeaderImage() {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         height: 120,
//         width: 120,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(16),
//           child: Image.network(
//             AppConstants.healthRiskAssessmentImage,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) => Container(
//               color: Colors.white.withOpacity(0.2),
//               child: const Icon(
//                 Icons.health_and_safety,
//                 color: Colors.white,
//                 size: 48,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContent(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildWhatYouGetSection(context),
//         const SizedBox(height: 32),
//         _buildHowWeDoItSection(context),
//         const SizedBox(height: 32),
//         _buildPrivacySection(),
//         const SizedBox(height: 24),
//         _buildInstructionsSection(),
//         const SizedBox(height: 32),
//         _buildStartButton(context),
//       ],
//     );
//   }

//   Widget _buildWhatYouGetSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'What do you get?',
//           style: AppTextStyles.titleLarge.copyWith(
//             fontWeight: FontWeight.w600,
//             color: AppColors.onBackground,
//           ),
//         ),
//         const SizedBox(height: 16),
//         ResponsiveBuilder(
//           mobile: _buildFeaturesMobile(),
//           tablet: _buildFeaturesTablet(),
//           desktop: _buildFeaturesDesktop(),
//         ),
//       ],
//     );
//   }

//   Widget _buildFeaturesMobile() {
//     return SizedBox(
//       height: 120,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: _features.length,
//         separatorBuilder: (context, index) => const SizedBox(width: 16),
//         itemBuilder: (context, index) => _buildFeatureCard(_features[index]),
//       ),
//     );
//   }

//   Widget _buildFeaturesTablet() {
//     return Wrap(
//       spacing: 16,
//       runSpacing: 16,
//       children: _features.map((feature) => _buildFeatureCard(feature)).toList(),
//     );
//   }

//   Widget _buildFeaturesDesktop() {
//     return Row(
//       children: _features
//           .map((feature) => Expanded(child: _buildFeatureCard(feature)))
//           .toList(),
//     );
//   }

//   Widget _buildFeatureCard(FeatureItem feature) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.shadow.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [AppColors.primary, AppColors.primaryVariant],
//               ),
//             ),
//             child: Icon(
//               feature.icon,
//               color: Colors.white,
//               size: 24,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             feature.label,
//             textAlign: TextAlign.center,
//             style: AppTextStyles.labelSmall.copyWith(
//               fontWeight: FontWeight.w600,
//               color: AppColors.onSurface,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHowWeDoItSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'How we do it?',
//           style: AppTextStyles.titleLarge.copyWith(
//             fontWeight: FontWeight.w600,
//             color: AppColors.onBackground,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           width: double.infinity,
//           height: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             gradient: LinearGradient(
//               colors: [
//                 AppColors.primary.withOpacity(0.1),
//                 AppColors.secondary.withOpacity(0.1)
//               ],
//             ),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.play_circle_filled,
//                   size: 64,
//                   color: AppColors.primary,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Watch Demo Video',
//                   style: AppTextStyles.titleMedium.copyWith(
//                     color: AppColors.primary,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPrivacySection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.successContainer,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.shield_outlined,
//             color: AppColors.success,
//             size: 24,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               'We do not store or share your personal data',
//               style: AppTextStyles.bodyMedium.copyWith(
//                 color: AppColors.onSuccessContainer,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInstructionsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Instructions:',
//           style: AppTextStyles.titleMedium.copyWith(
//             fontWeight: FontWeight.w600,
//             color: AppColors.onBackground,
//           ),
//         ),
//         const SizedBox(height: 12),
//         ..._instructions.asMap().entries.map((entry) {
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 24,
//                   height: 24,
//                   decoration: BoxDecoration(
//                     color: AppColors.primary,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${entry.key + 1}',
//                       style: AppTextStyles.labelSmall.copyWith(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     entry.value,
//                     style: AppTextStyles.bodyMedium.copyWith(
//                       color: AppColors.onSurfaceVariant,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ],
//     );
//   }

//   Widget _buildStartButton(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: AppButton.primary(
//         text: 'Start Assessment',
//         size: ButtonSize.large,
//         onPressed: () {
//           // Handle start assessment
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Starting Health Risk Assessment...')),
//           );
//         },
//       ),
//     );
//   }

//   // Data
//   final List<FeatureItem> _features = [
//     FeatureItem(icon: Icons.favorite, label: 'Key Body Vitals'),
//     FeatureItem(icon: Icons.accessibility_new, label: 'Posture Analysis'),
//     FeatureItem(icon: Icons.fitness_center, label: 'Body Composition'),
//     FeatureItem(icon: Icons.assessment, label: 'Instant Reports'),
//   ];

//   final List<String> _instructions = [
//     'Ensure that you are in a well-lit space',
//     'Allow camera access and place your device against a stable object or wall',
//     'Avoid wearing baggy clothes',
//     'Make sure you exercise as per the instruction provided by the trainer',
//   ];
// }

// class FeatureItem {
//   final IconData icon;
//   final String label;

//   FeatureItem({required this.icon, required this.label});
// }
