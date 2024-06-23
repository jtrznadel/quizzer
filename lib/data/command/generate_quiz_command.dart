import 'package:quizzer/data/command/command.dart';
import 'package:quizzer/data/question/question_manager.dart';

class GenerateQuizCommand implements Command {
  final QuizManager quizManager;
  final int numberOfQuestions;

  GenerateQuizCommand(
      {required this.quizManager, required this.numberOfQuestions});

  @override
  void execute() {
    quizManager.generateQuiz(numberOfQuestions: numberOfQuestions);
  }
}
