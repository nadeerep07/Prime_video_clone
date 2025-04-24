import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;
}
