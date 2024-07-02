import 'package:quizzer/data/question/question.dart';
import 'package:quizzer/data/question/question_loader.dart';
import 'package:quizzer/data/question/question_factory.dart';

class QuizManager {
  final List<Question> _questions = [];
  final QuestionFactory questionFactory = QuestionFactory();
  int _score = 0;

  void addQuestion(Question question) {
    _questions.add(question);
  }

  List<Question> getQuestions() {
    return List.unmodifiable(_questions);
  }

  void checkAnswer(Question question, int selectedAnswer) {
    if (question.correctAnswerIndex == selectedAnswer) {
      _score++;
    }
  }

  int getScore() {
    return _score;
  }

  void resetScore() {
    _score = 0;
  }

  void clearQuestions() {
    _questions.clear();
  }

  Future<void> generateQuiz(int questionCount) async {
    final questionLoader = QuestionLoader();
    final questions =
        await questionLoader.loadQuestions(questionFactory, questionCount);

    _questions.clear();
    for (var question in questions) {
      addQuestion(question);
    }
  }
}
