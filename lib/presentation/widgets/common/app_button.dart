import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

/// Reusable button widget with consistent styling
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final bool isLoading;
  final bool isEnabled;
  final Widget? icon;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
    this.height,
  });

  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
    this.height,
  }) : type = ButtonType.primary;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
    this.height,
  }) : type = ButtonType.secondary;

  const AppButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
    this.height,
  }) : type = ButtonType.outline;

  const AppButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
    this.height,
  }) : type = ButtonType.text;

  @override
  Widget build(BuildContext context) {
    final buttonSize = _getButtonSize();
    final isDisabled = !isEnabled || isLoading;

    Widget buttonChild = _buildButtonChild();

    switch (type) {
      case ButtonType.primary:
        return SizedBox(
          width: width,
          height: height ?? buttonSize.height,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              disabledBackgroundColor: AppColors.onSurfaceVariant,
              disabledForegroundColor: AppColors.surface,
              elevation: 2,
              shadowColor: AppColors.shadow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: buttonSize.horizontalPadding,
                vertical: buttonSize.verticalPadding,
              ),
              textStyle: _getTextStyle(),
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.secondary:
        return SizedBox(
          width: width,
          height: height ?? buttonSize.height,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.onSecondary,
              disabledBackgroundColor: AppColors.onSurfaceVariant,
              disabledForegroundColor: AppColors.surface,
              elevation: 2,
              shadowColor: AppColors.shadow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: buttonSize.horizontalPadding,
                vertical: buttonSize.verticalPadding,
              ),
              textStyle: _getTextStyle(),
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.outline:
        return SizedBox(
          width: width,
          height: height ?? buttonSize.height,
          child: OutlinedButton(
            onPressed: isDisabled ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              disabledForegroundColor: AppColors.onSurfaceVariant,
              side: BorderSide(
                color: isDisabled ? AppColors.onSurfaceVariant : AppColors.primary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: buttonSize.horizontalPadding,
                vertical: buttonSize.verticalPadding,
              ),
              textStyle: _getTextStyle(),
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.text:
        return SizedBox(
          width: width,
          height: height ?? buttonSize.height,
          child: TextButton(
            onPressed: isDisabled ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              disabledForegroundColor: AppColors.onSurfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: buttonSize.horizontalPadding,
                vertical: buttonSize.verticalPadding,
              ),
              textStyle: _getTextStyle(),
            ),
            child: buttonChild,
          ),
        );
    }
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        width: _getButtonSize().iconSize,
        height: _getButtonSize().iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == ButtonType.primary || type == ButtonType.secondary
                ? AppColors.onPrimary
                : AppColors.primary,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w600);
      case ButtonSize.medium:
        return AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600);
      case ButtonSize.large:
        return AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w600);
    }
  }

  _ButtonSize _getButtonSize() {
    switch (size) {
      case ButtonSize.small:
        return const _ButtonSize(
          height: 32,
          horizontalPadding: 16,
          verticalPadding: 8,
          iconSize: 16,
        );
      case ButtonSize.medium:
        return const _ButtonSize(
          height: 40,
          horizontalPadding: 20,
          verticalPadding: 10,
          iconSize: 20,
        );
      case ButtonSize.large:
        return const _ButtonSize(
          height: 48,
          horizontalPadding: 24,
          verticalPadding: 12,
          iconSize: 24,
        );
    }
  }
}

/// Button type enumeration
enum ButtonType {
  primary,
  secondary,
  outline,
  text,
}

/// Button size enumeration
enum ButtonSize {
  small,
  medium,
  large,
}

/// Internal button size configuration
class _ButtonSize {
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double iconSize;

  const _ButtonSize({
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.iconSize,
  });
}
