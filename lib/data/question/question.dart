import 'package:quizzer/data/question_type.dart';

class Question {
  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.questionType,
  });

  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final QuestionType questionType;

  bool isCorrect({required int answerIndex}) {
    return answerIndex == correctAnswerIndex;
  }
}
