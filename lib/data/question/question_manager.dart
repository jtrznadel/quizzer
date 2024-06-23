import 'package:quizzer/data/question/question.dart';
import 'package:quizzer/data/question/question_factory.dart';

class QuizManager {
  final QuestionFactory questionFactory;
  List<Question> currentQuestions = [];
  int score = 0;

  QuizManager({required this.questionFactory});

  void generateQuiz({required int numberOfQuestions}) {
    currentQuestions = List.generate(numberOfQuestions, (index) {
      final questionType = questionFactory.getQuestionType(
          category: category, color: color, image: image);
      return questionType.createQuestion(
          questionText: questionText,
          options: options,
          correctAnswerIndex: correctAnswerIndex);
    });
  }

  bool checkAnswer({required int questionId, required int answerIndex}) {
    final isCorrect =
        currentQuestions[questionId].isCorrect(answerIndex: answerIndex);
    if (isCorrect) {
      score += 1;
    }
    return isCorrect;
  }

  int getScore() {
    return score;
  }
}
