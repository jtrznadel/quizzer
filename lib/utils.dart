import 'package:flutter/material.dart';

class IconUtils {
  static IconData getIconFromString(String iconString) {
    switch (iconString) {
      case 'Icons.music_note':
        return Icons.music_note;
      case 'Icons.calculate':
        return Icons.calculate;
      case 'Icons.rocket_launch_outlined':
        return Icons.rocket_launch_outlined;
      case 'Icons.public':
        return Icons.public;
      case 'Icons.menu_book':
        return Icons.menu_book;
      case 'Icons.sports_volleyball_outlined':
        return Icons.sports_volleyball_outlined;
      default:
        return Icons.help;
    }
  }
}
