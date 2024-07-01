// Concrete command for generating a quiz
import 'package:quizzer/data/command/command.dart';
import 'package:quizzer/data/question/question_factory.dart';
import 'package:quizzer/data/question/quiz_manager.dart';

class GenerateQuizCommand implements Command {
  final QuizManager quizManager;
  final QuestionFactory questionFactory;

  GenerateQuizCommand(this.quizManager, this.questionFactory);

  @override
  void execute() {
    quizManager.generateQuiz(questionFactory);
    print('Quiz generated.');
  }
}
