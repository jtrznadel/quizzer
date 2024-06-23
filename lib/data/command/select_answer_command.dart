import 'package:quizzer/data/command/command.dart';
import 'package:quizzer/data/question/question_manager.dart';

class SelectAnswerCommand implements Command {
  final int questionId;
  final int selectedAnswerIndex;
  final QuizManager quizManager;

  SelectAnswerCommand(
      {required this.questionId,
      required this.selectedAnswerIndex,
      required this.quizManager});

  @override
  void execute() {
    quizManager.checkAnswer(
        questionId: questionId, answerIndex: selectedAnswerIndex);
  }
}
