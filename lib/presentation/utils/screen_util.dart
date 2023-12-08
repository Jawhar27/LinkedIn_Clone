import 'package:flutter/material.dart';

class ScreenUtils {
  static Size? screenSize;
  static MediaQueryData? mqData;
  static Size? get size => screenSize;
  static double get height => size!.height;
  static double get width => size!.width;
}