import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class ResponsiveSize {
  static double font(double px) {
    final screenHeight = 100.h;
    return (px / screenHeight) * 100;
  }

  static double width(double px) {
    final screenWidth = 100.w;
    return (px / screenWidth) * 100;
  }

  static double height(double px) {
    final screenHeight = 100.h;
    return (px / screenHeight) * 100;
  }
}

extension ResponsiveSpacing on num {
  double get sp => ResponsiveSize.font(toDouble());
  double get rw => ResponsiveSize.width(toDouble());
  double get rh => ResponsiveSize.height(toDouble());

  EdgeInsets get allPadding => EdgeInsets.all(rh);
  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: rw);
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: rh);

  EdgeInsets symmetricPadding({num? horizontal, num? vertical}) {
    return EdgeInsets.symmetric(
      horizontal: (horizontal ?? 0).rw,
      vertical: (vertical ?? 0).rh,
    );
  }

  EdgeInsets onlyPadding({num? left, num? top, num? right, num? bottom}) {
    return EdgeInsets.only(
      left: (left ?? 0).rw,
      top: (top ?? 0).rh,
      right: (right ?? 0).rw,
      bottom: (bottom ?? 0).rh,
    );
  }

  Widget get vSpace => SizedBox(height: rh);
  Widget get hSpace => SizedBox(width: rw);
}
