import 'package:quizzer/data/question/question.dart';

class QuestionType {
  const QuestionType(
      {required String category, required String color, required String image})
      : _category = category,
        _color = color,
        _image = image;

  final String _category;
  final String _color;
  final String _image;

  Question createQuestion({
    required String questionText,
    required List<String> options,
    required int correctAnswerIndex,
  }) {
    return Question(
      questionText: questionText,
      options: options,
      correctAnswerIndex: correctAnswerIndex,
      questionType: this,
    );
  }
}
