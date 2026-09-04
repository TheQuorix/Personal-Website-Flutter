import 'package:flutter/material.dart';

const _mobileBreakpoint = 600.0;

bool isMobile(BuildContext context) {
  return MediaQuery.sizeOf(context).width < _mobileBreakpoint;
}
