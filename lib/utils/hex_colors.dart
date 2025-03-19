/*
https://github.com/suryavip/flutter_utils
version: 2
*/

import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${((0xff000000 & toARGB32()) >> 24).toRadixString(16).padLeft(2, '0')}'
      '${((0x00ff0000 & toARGB32()) >> 16).toRadixString(16).padLeft(2, '0')}'
      '${((0x0000ff00 & toARGB32()) >> 8).toRadixString(16).padLeft(2, '0')}'
      '${((0x000000ff & toARGB32()) >> 0).toRadixString(16).padLeft(2, '0')}';
}
