// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../core/theme/app_colors.dart';
// import '../../core/theme/app_text_styles.dart';
// import '../../core/theme/theme_provider.dart';
// import '../../core/constants/app_constants.dart';
// import '../widgets/common/responsive_builder.dart';
// import '../widgets/common/app_card.dart';
// import '../widgets/common/app_button.dart';
// import 'my_appointment.dart';
// import 'settings_screen.dart';

// class ResponsiveMyAssessments extends StatefulWidget {
//   const ResponsiveMyAssessments({super.key});

//   @override
//   State<ResponsiveMyAssessments> createState() =>
//       _ResponsiveMyAssessmentsState();
// }

// class _ResponsiveMyAssessmentsState extends State<ResponsiveMyAssessments>
//     with TickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: ResponsivePadding(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTabBar(),
//             const ResponsiveSpacing.vertical(
//                 mobile: 12, tablet: 16, desktop: 20),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildMyAssessmentsTab(),
//                   MyAppointment(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       title: const Text('Hello Jane'),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.notifications_outlined),
//           onPressed: () {
//             // Handle notifications
//           },
//         ),
//         Consumer<ThemeProvider>(
//           builder: (context, themeProvider, child) {
//             return IconButton(
//               icon: Icon(
//                 themeProvider.isDarkMode
//                     ? Icons.light_mode_outlined
//                     : Icons.dark_mode_outlined,
//               ),
//               onPressed: () {
//                 themeProvider.toggleTheme();
//               },
//             );
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.settings_outlined),
//           onPressed: () {
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder: (_) => const SettingsScreen()),
//             // );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildTabBar() {
//     return TabBar(
//       controller: _tabController,
//       tabs: const [
//         Tab(text: 'My Assessments'),
//         Tab(text: 'My Appointments'),
//       ],
//     );
//   }

//   Widget _buildMyAssessmentsTab() {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildAssessmentsSection(),
//           const ResponsiveSpacing.vertical(mobile: 24, tablet: 32, desktop: 40),
//           _buildChallengesSection(),
//           const ResponsiveSpacing.vertical(mobile: 24, tablet: 32, desktop: 40),
//           _buildWorkoutRoutinesSection(),
//           const ResponsiveSpacing.vertical(mobile: 20, tablet: 24, desktop: 32),
//         ],
//       ),
//     );
//   }

//   Widget _buildAssessmentsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ResponsiveBuilder(
//           mobile: _buildAssessmentsMobile(),
//           tablet: _buildAssessmentsTablet(),
//           desktop: _buildAssessmentsDesktop(),
//         ),
//         const ResponsiveSpacing.vertical(mobile: 16, tablet: 20, desktop: 24),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: AppButton.outline(
//             text: 'View all',
//             size: ButtonSize.small,
//             onPressed: () {
//               // Handle view all assessments
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAssessmentsMobile() {
//     return Column(
//       children: [
//         AssessmentCard(
//           imageUrl: AppConstants.fitnessAssessmentImage,
//           title: 'Fitness Assessment',
//           description:
//               'Get Started On Your Fitness Goals With Our Physical Assessment And Vital Scan',
//           onTap: () {
//             // Handle fitness assessment tap
//           },
//         ),
//         AssessmentCard(
//           imageUrl: AppConstants.healthRiskAssessmentImage,
//           title: 'Health Risk Assessment',
//           description:
//               'Identify And Mitigate Health Risks With Precise, Proactive Assessments',
//           onTap: () {
//             // Handle health risk assessment tap
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildAssessmentsTablet() {
//     return Row(
//       children: [
//         Expanded(
//           child: AssessmentCard(
//             imageUrl: AppConstants.fitnessAssessmentImage,
//             title: 'Fitness Assessment',
//             description:
//                 'Get Started On Your Fitness Goals With Our Physical Assessment And Vital Scan',
//             onTap: () {
//               // Handle fitness assessment tap
//             },
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: AssessmentCard(
//             imageUrl: AppConstants.healthRiskAssessmentImage,
//             title: 'Health Risk Assessment',
//             description:
//                 'Identify And Mitigate Health Risks With Precise, Proactive Assessments',
//             onTap: () {
//               // Handle health risk assessment tap
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAssessmentsDesktop() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 2,
//           child: AssessmentCard(
//             imageUrl: AppConstants.fitnessAssessmentImage,
//             title: 'Fitness Assessment',
//             description:
//                 'Get Started On Your Fitness Goals With Our Physical Assessment And Vital Scan',
//             onTap: () {
//               // Handle fitness assessment tap
//             },
//           ),
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           flex: 2,
//           child: AssessmentCard(
//             imageUrl: AppConstants.healthRiskAssessmentImage,
//             title: 'Health Risk Assessment',
//             description:
//                 'Identify And Mitigate Health Risks With Precise, Proactive Assessments',
//             onTap: () {
//               // Handle health risk assessment tap
//             },
//           ),
//         ),
//         const Expanded(flex: 1, child: SizedBox()), // Spacer for better layout
//       ],
//     );
//   }

//   Widget _buildChallengesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader(
//           title: 'Challenges',
//           onViewAll: () {
//             // Handle challenges view all
//           },
//         ),
//         const ResponsiveSpacing.vertical(mobile: 12, tablet: 16, desktop: 20),
//         _buildChallengeCard(),
//       ],
//     );
//   }

//   Widget _buildWorkoutRoutinesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader(
//           title: 'Workout Routines',
//           onViewAll: () {
//             // Handle workout routines view all
//           },
//         ),
//         const ResponsiveSpacing.vertical(mobile: 12, tablet: 16, desktop: 20),
//         ResponsiveBuilder(
//           mobile: _buildWorkoutsMobile(),
//           tablet: _buildWorkoutsTablet(),
//           desktop: _buildWorkoutsDesktop(),
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionHeader({
//     required String title,
//     required VoidCallback onViewAll,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: AppTextStyles.sectionHeader,
//         ),
//         AppButton.text(
//           text: 'View all',
//           size: ButtonSize.small,
//           onPressed: onViewAll,
//         ),
//       ],
//     );
//   }

//   Widget _buildChallengeCard() {
//     return AppCard(
//       backgroundColor: AppColors.challengeBackground,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Today's Challenge!",
//             style: AppTextStyles.titleMedium.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             'Push Up 20x',
//             style: AppTextStyles.titleLarge.copyWith(
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 10),
//           const LinearProgressIndicator(
//             value: 0.5,
//             backgroundColor: AppColors.challengeIncomplete,
//             valueColor:
//                 AlwaysStoppedAnimation<Color>(AppColors.challengeProgress),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             '10/20 Complete',
//             style: AppTextStyles.bodyMedium,
//           ),
//           const SizedBox(height: 12),
//           AppButton.primary(
//             text: 'Continue',
//             size: ButtonSize.small,
//             onPressed: () {
//               // Handle continue challenge
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWorkoutsMobile() {
//     return Column(
//       children: [
//         WorkoutCard(
//           imageUrl: AppConstants.sweatStarterWorkoutImage,
//           title: 'Sweat Starter',
//           subtitle: 'Full Body',
//           tagText: 'Lose Weight',
//           tagColor: AppColors.loseWeightTag,
//           difficulty: 'Medium',
//           onTap: () {
//             // Handle workout tap
//           },
//         ),
//         WorkoutCard(
//           imageUrl: AppConstants.strengthBuilderWorkoutImage,
//           title: 'Strength Builder',
//           subtitle: 'Upper Body',
//           tagText: 'Build Muscle',
//           tagColor: AppColors.buildMuscleTag,
//           difficulty: 'Hard',
//           onTap: () {
//             // Handle workout tap
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildWorkoutsTablet() {
//     return Row(
//       children: [
//         Expanded(
//           child: WorkoutCard(
//             imageUrl: AppConstants.sweatStarterWorkoutImage,
//             title: 'Sweat Starter',
//             subtitle: 'Full Body',
//             tagText: 'Lose Weight',
//             tagColor: AppColors.loseWeightTag,
//             difficulty: 'Medium',
//             onTap: () {
//               // Handle workout tap
//             },
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: WorkoutCard(
//             imageUrl: AppConstants.strengthBuilderWorkoutImage,
//             title: 'Strength Builder',
//             subtitle: 'Upper Body',
//             tagText: 'Build Muscle',
//             tagColor: AppColors.buildMuscleTag,
//             difficulty: 'Hard',
//             onTap: () {
//               // Handle workout tap
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildWorkoutsDesktop() {
//     return Row(
//       children: [
//         Expanded(
//           child: WorkoutCard(
//             imageUrl: AppConstants.sweatStarterWorkoutImage,
//             title: 'Sweat Starter',
//             subtitle: 'Full Body',
//             tagText: 'Lose Weight',
//             tagColor: AppColors.loseWeightTag,
//             difficulty: 'Medium',
//             onTap: () {
//               // Handle workout tap
//             },
//           ),
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           child: WorkoutCard(
//             imageUrl: AppConstants.strengthBuilderWorkoutImage,
//             title: 'Strength Builder',
//             subtitle: 'Upper Body',
//             tagText: 'Build Muscle',
//             tagColor: AppColors.buildMuscleTag,
//             difficulty: 'Hard',
//             onTap: () {
//               // Handle workout tap
//             },
//           ),
//         ),
//         const Expanded(child: SizedBox()), // Spacer for better layout
//       ],
//     );
//   }
// }
