import 'package:quizzer/data/question_type.dart';

class QuestionFactory {
  final Map<String, QuestionType> _questionTypes = {};

  QuestionType getQuestionType({
    required String category,
    required String color,
    required String image,
  }) {
    final key = category;
    if (!_questionTypes.containsKey(key)) {
      _questionTypes[key] =
          QuestionType(category: category, color: color, image: image);
    }
    return _questionTypes[key]!;
  }
}
