import 'dart:ui';

import 'package:quizzer/data/question/question_type.dart';

class QuestionFactory {
  final Map<String, QuestionType> _questionTypes = {};

  QuestionType getQuestionType(String category, Color color, String icon) {
    final key = category + color.toString() + icon;

    if (!_questionTypes.containsKey(key)) {
      _questionTypes[key] =
          QuestionType(category: category, color: color, icon: icon);
      print('Creating new QuizzType: $key\n\n');
    } else {
      print('Reusing existing QuizzType: $key\n\n');
    }

    return _questionTypes[key]!;
  }
}
