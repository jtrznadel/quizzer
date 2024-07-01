import 'package:quizzer/data/command/command.dart';
import 'package:quizzer/data/question/quiz_manager.dart';

class DisplayScoreCommand implements Command {
  final QuizManager quizManager;

  DisplayScoreCommand(this.quizManager);

  @override
  void execute() {
    quizManager.getScore();
    print('Current score: ${quizManager.getScore()}');
  }
}
