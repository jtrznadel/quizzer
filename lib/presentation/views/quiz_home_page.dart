import 'package:flutter/material.dart';
import 'package:quizzer/data/command/command_invoker.dart';
import 'package:quizzer/data/command/display_score_command.dart';
import 'package:quizzer/data/command/generate_quiz_command.dart';
import 'package:quizzer/data/command/reset_score_command.dart';
import 'package:quizzer/data/question/question_factory.dart';
import 'package:quizzer/data/question/quiz_manager.dart';
import 'package:quizzer/data/question/question.dart';
import 'package:quizzer/utils.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final questionTypeFactory = QuestionFactory();
  final quizManager = QuizManager();
  final commandInvoker = CommandInvoker();
  int _currentQuestionIndex = 0;
  bool _quizCompleted = false;
  String _scoreMessage = '';
  bool _showScore = false;

  void _generateQuiz() async {
    final generateQuizCommand = GenerateQuizCommand(quizManager, 5);
    commandInvoker.setCommand(generateQuizCommand);
    commandInvoker.executeCommand();

    // Poczekaj na zakończenie generowania quizu i odśwież stan
    await Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _currentQuestionIndex = 0;
        _quizCompleted = false;
        _scoreMessage = '';
        _showScore = false;
      });
    });
  }

  void _resetQuiz() {
    final resetScoreCommand = ResetScoreCommand(quizManager);
    commandInvoker.setCommand(resetScoreCommand);
    commandInvoker.executeCommand();

    setState(() {
      _currentQuestionIndex = 0;
      _quizCompleted = false;
      _scoreMessage = '';
      _showScore = false;
    });
  }

  void _displayScore() {
    final displayScoreCommand = DisplayScoreCommand(quizManager);
    commandInvoker.setCommand(displayScoreCommand);
    commandInvoker.executeCommand();
    setState(() {
      _scoreMessage = quizManager.getScore().toString();
      _showScore = true;
    });
  }

  void _playAgain() {
    _resetQuiz();
  }

  void _answerQuestion(int answerIndex) {
    quizManager.checkAnswer(
        quizManager.getQuestions()[_currentQuestionIndex], answerIndex);
    setState(() {
      if (_currentQuestionIndex < quizManager.getQuestions().length - 1) {
        _currentQuestionIndex++;
      } else {
        _quizCompleted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = quizManager.getQuestions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          if (!_quizCompleted) // Dodaj ten warunek, aby przycisk odświeżania był widoczny tylko podczas trwania quizu
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetQuiz,
            ),
        ],
      ),
      body: Center(
        child: _quizCompleted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Quiz completed!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your score is',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child: _showScore
                        ? Text(
                            _scoreMessage,
                            style: const TextStyle(
                                fontSize: 48, fontWeight: FontWeight.bold),
                            key: const ValueKey('scoreText'),
                          )
                        : const Icon(
                            Icons.question_mark,
                            size: 100,
                            key: ValueKey('questionMark'),
                          ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _displayScore,
                    child: const Text('Display Score'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _playAgain,
                    child: const Text('Play Again'),
                  ),
                ],
              )
            : questions.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Welcome to the Quiz App!',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'You will be presented with 5 questions from different categories. Try to answer as many questions correctly as you can!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _generateQuiz,
                          child: const Text('Generate Quiz'),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(30),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          IconUtils.getIconFromString(
                              questions[_currentQuestionIndex]
                                  .questionType
                                  .getIcon()),
                          size: 64,
                        ),
                        const SizedBox(height: 40),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: questions[_currentQuestionIndex]
                                .questionType
                                .getColor(),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            questions[_currentQuestionIndex].questionText,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...questions[_currentQuestionIndex]
                            .options
                            .asMap()
                            .entries
                            .map(
                              (entry) => ElevatedButton(
                                onPressed: () => _answerQuestion(entry.key),
                                child: Text(entry.value),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
