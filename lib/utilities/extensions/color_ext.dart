import 'package:flutter/material.dart';

extension HexColorExt on String {
  Color hexToColor() {
    var hexCode = replaceAll("#", "");
    if (hexCode.length == 6) {
      hexCode = "FF$hexCode"; // Add full opacity if not specified
    }
    return Color(int.parse(hexCode, radix: 16));
  }
}

extension ColorExt on Color {
  bool get isDarkBackground => computeLuminance() < 0.3;

  Color get getTextColor => isDarkBackground ? Colors.white : Colors.black;
}
