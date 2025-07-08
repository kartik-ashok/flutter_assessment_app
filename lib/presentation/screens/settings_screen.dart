// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../core/theme/app_colors.dart';
// import '../../core/theme/app_text_styles.dart';
// import '../../core/theme/theme_provider.dart';
// import '../../core/utils/responsive_utils.dart';
// import '../../domain/repository/auth_service.dart';
// import '../widgets/common/responsive_builder.dart';
// import '../widgets/common/app_card.dart';
// import '../widgets/common/app_button.dart';
// import '../widgets/common/theme_switch_widget.dart';
// import 'login_page.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: ResponsivePadding(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildUserSection(context),
//               const ResponsiveSpacing.vertical(mobile: 24, tablet: 32, desktop: 40),
//               const ThemeSwitchWidget(),
//               const ResponsiveSpacing.vertical(mobile: 24, tablet: 32, desktop: 40),
//               _buildAppInfoSection(context),
//               const ResponsiveSpacing.vertical(mobile: 24, tablet: 32, desktop: 40),
//               _buildSignOutSection(context),
//               const ResponsiveSpacing.vertical(mobile: 40, tablet: 48, desktop: 56),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserSection(BuildContext context) {
//     return AppCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'User Profile',
//             style: AppTextStyles.titleMedium.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: ResponsiveUtils.getResponsiveValue(
//                   context,
//                   mobile: 30.0,
//                   tablet: 35.0,
//                   desktop: 40.0,
//                 ),
//                 backgroundColor: AppColors.primary,
//                 child: Icon(
//                   Icons.person,
//                   color: AppColors.onPrimary,
//                   size: ResponsiveUtils.getResponsiveValue(
//                     context,
//                     mobile: 30.0,
//                     tablet: 35.0,
//                     desktop: 40.0,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Jane Doe',
//                       style: AppTextStyles.titleMedium.copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'jane.doe@example.com',
//                       style: AppTextStyles.bodyMedium.copyWith(
//                         color: AppColors.onSurfaceVariant,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               AppButton.outline(
//                 text: 'Edit',
//                 size: ButtonSize.small,
//                 onPressed: () {
//                   // Handle edit profile
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppInfoSection(BuildContext context) {
//     return AppCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'App Information',
//             style: AppTextStyles.titleMedium.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildInfoRow('Version', '1.0.0'),
//           const SizedBox(height: 8),
//           _buildInfoRow('Build', '1'),
//           const SizedBox(height: 8),
//           _buildInfoRow('Device Type', _getDeviceTypeString(context)),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: AppTextStyles.bodyMedium,
//         ),
//         Text(
//           value,
//           style: AppTextStyles.bodyMedium.copyWith(
//             color: AppColors.onSurfaceVariant,
//           ),
//         ),
//       ],
//     );
//   }

//   String _getDeviceTypeString(BuildContext context) {
//     final deviceType = ResponsiveUtils.getDeviceType(context);
//     switch (deviceType) {
//       case DeviceType.mobile:
//         return 'Mobile';
//       case DeviceType.tablet:
//         return 'Tablet';
//       case DeviceType.desktop:
//         return 'Desktop';
//     }
//   }

//   Widget _buildSignOutSection(BuildContext context) {
//     return AppCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Account Actions',
//             style: AppTextStyles.titleMedium.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: AppButton(
//               text: 'Sign Out',
//               type: ButtonType.outline,
//               onPressed: () => _handleSignOut(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _handleSignOut(BuildContext context) async {
//     // Show confirmation dialog
//     final shouldSignOut = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Sign Out'),
//         content: const Text('Are you sure you want to sign out?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Sign Out'),
//           ),
//         ],
//       ),
//     );

//     if (shouldSignOut == true && context.mounted) {
//       try {
//         final authService = AuthService();
//         await authService.signOut();
        
//         if (context.mounted) {
//           Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (_) => const LoginScreen()),
//             (route) => false,
//           );
//         }
//       } catch (e) {
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error signing out: $e')),
//           );
//         }
//       }
//     }
//   }
// }
