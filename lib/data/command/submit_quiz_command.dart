import 'package:quizzer/data/command/command.dart';
import 'package:quizzer/data/question/question_manager.dart';

class SubmitQuizCommand implements Command {
  final QuizManager quizManager;

  SubmitQuizCommand({required this.quizManager});

  @override
  void execute() {
    quizManager.getScore();
  }
}
