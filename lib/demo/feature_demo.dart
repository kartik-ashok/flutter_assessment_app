import 'package:flutter/material.dart';
import 'package:flutter_assessment_app/core/constants/app_constants.dart';
import 'package:provider/provider.dart';
import '../core/theme/theme_provider.dart';
import '../core/services/shared_preferences_service.dart';
import '../core/utils/responsive_utils.dart';
import '../core/constants/api_constants.dart';
import '../presentation/widgets/common/responsive_builder.dart';
import '../presentation/widgets/common/app_button.dart';
import '../presentation/widgets/common/app_card.dart';

/// Demo screen showcasing the new architecture features
class FeatureDemoScreen extends StatefulWidget {
  const FeatureDemoScreen({super.key});

  @override
  State<FeatureDemoScreen> createState() => _FeatureDemoScreenState();
}

class _FeatureDemoScreenState extends State<FeatureDemoScreen> {
  final _prefsService = SharedPreferencesService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Architecture Demo'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: ResponsivePadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResponsiveDemo(),
              const ResponsiveSpacing.vertical(mobile: 24, tablet: 32),
              _buildThemeDemo(),
              const ResponsiveSpacing.vertical(mobile: 24, tablet: 32),
              _buildSharedPrefsDemo(),
              const ResponsiveSpacing.vertical(mobile: 24, tablet: 32),
              _buildUrlConstantsDemo(),
              const ResponsiveSpacing.vertical(mobile: 24, tablet: 32),
              _buildWidgetLibraryDemo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveDemo() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Responsive Design Demo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text('Current Device Type: ${_getDeviceTypeString()}'),
          Text('Screen Width: ${MediaQuery.of(context).size.width.toInt()}px'),
          const SizedBox(height: 16),
          ResponsiveBuilder(
            mobile: _buildMobileLayout(),
            tablet: _buildTabletLayout(),
            desktop: _buildDesktopLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.withOpacity(0.1),
      child: const Text('Mobile Layout (< 600px)'),
    );
  }

  Widget _buildTabletLayout() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.green.withOpacity(0.1),
      child: const Text('Tablet Layout (600px - 1024px)'),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.orange.withOpacity(0.1),
      child: const Text('Desktop Layout (> 1024px)'),
    );
  }

  String _getDeviceTypeString() {
    final deviceType = ResponsiveUtils.getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return 'Mobile';
      case DeviceType.tablet:
        return 'Tablet';
      case DeviceType.desktop:
        return 'Desktop';
    }
  }

  Widget _buildThemeDemo() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Theme Management Demo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text('Current Theme: ${themeProvider.themeMode.name}'),
              Text('Is Dark Mode: ${themeProvider.isDarkMode}'),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  AppButton.outline(
                    text: 'Light',
                    size: ButtonSize.small,
                    onPressed: () => themeProvider.setLightTheme(),
                  ),
                  AppButton.outline(
                    text: 'Dark',
                    size: ButtonSize.small,
                    onPressed: () => themeProvider.setDarkTheme(),
                  ),
                  AppButton.outline(
                    text: 'System',
                    size: ButtonSize.small,
                    onPressed: () => themeProvider.setSystemTheme(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSharedPrefsDemo() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shared Preferences Demo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text('Theme Setting: ${_prefsService.getThemeMode()}'),
          Text('Language: ${_prefsService.getLanguageCode()}'),
          Text('Is First Time: ${_prefsService.isFirstTime()}'),
          const SizedBox(height: 16),
          AppButton.primary(
            text: 'Save Demo Data',
            size: ButtonSize.small,
            onPressed: () async {
              await _prefsService.setString('demo_key', 'Demo Value');
              await _prefsService.setFirstTime(false);
              setState(() {});
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Demo data saved!')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUrlConstantsDemo() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'URL Constants Demo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text('Base URL: ${ApiConstants.baseUrl}'),
          Text('Image Base: ${AppConstants.imageBaseUrl}'),
          const SizedBox(height: 8),
          const Text('Endpoints:',
              style: TextStyle(fontWeight: FontWeight.w600)),
          Text('• Login: ${ApiConstants.loginEndpoint}'),
          Text('• Assessments: ${ApiConstants.assessmentsEndpoint}'),
          Text('• Appointments: ${ApiConstants.appointmentsEndpoint}'),
        ],
      ),
    );
  }

  Widget _buildWidgetLibraryDemo() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Widget Library Demo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Button Variants:'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppButton.primary(
                text: 'Primary',
                size: ButtonSize.small,
                onPressed: () {},
              ),
              AppButton.secondary(
                text: 'Secondary',
                size: ButtonSize.small,
                onPressed: () {},
              ),
              AppButton.outline(
                text: 'Outline',
                size: ButtonSize.small,
                onPressed: () {},
              ),
              AppButton.text(
                text: 'Text',
                size: ButtonSize.small,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Button Sizes:'),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton.primary(
                text: 'Small Button',
                size: ButtonSize.small,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              AppButton.primary(
                text: 'Medium Button',
                size: ButtonSize.medium,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              AppButton.primary(
                text: 'Large Button',
                size: ButtonSize.large,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
