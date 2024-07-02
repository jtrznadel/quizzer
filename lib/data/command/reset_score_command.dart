import 'package:quizzer/data/command/command.dart';
import 'package:quizzer/data/question/quiz_manager.dart';

class ResetScoreCommand implements Command {
  final QuizManager quizManager;

  ResetScoreCommand(this.quizManager);

  @override
  void execute() {
    quizManager.resetScore();
    quizManager.clearQuestions();
    print('Quzi and score reseted.');
  }
}
