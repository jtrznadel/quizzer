import 'dart:ui';

import 'package:quizzer/data/question/question.dart';

class QuestionType {
  const QuestionType(
      {required String category, required Color color, required String icon})
      : _category = category,
        _color = color,
        _icon = icon;

  final String _category;
  final Color _color;
  final String _icon;

  String getCategory() {
    return _category;
  }

  Color getColor() {
    return _color;
  }

  String getIcon() {
    return _icon;
  }
}
