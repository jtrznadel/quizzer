import 'package:flutter/material.dart';
import 'package:quizzer/data/command/command_invoker.dart';
import 'package:quizzer/data/command/display_score_command.dart';
import 'package:quizzer/data/command/generate_quiz_command.dart';
import 'package:quizzer/data/command/reset_score_command.dart';
import 'package:quizzer/data/question/question_factory.dart';
import 'package:quizzer/data/question/quiz_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final questionTypeFactory = QuestionFactory();
  final quizManager = QuizManager();
  final commandInvoker = CommandInvoker();

  void _generateQuiz() {
    final generateQuizCommand =
        GenerateQuizCommand(quizManager, questionTypeFactory);
    commandInvoker.setCommand(generateQuizCommand);
    commandInvoker.executeCommand();
  }

  void _resetScore() {
    final resetScoreCommand = ResetScoreCommand(quizManager);
    commandInvoker.setCommand(resetScoreCommand);
    commandInvoker.executeCommand();
  }

  void _displayScore() {
    final displayScoreCommand = DisplayScoreCommand(quizManager);
    commandInvoker.setCommand(displayScoreCommand);
    commandInvoker.executeCommand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _generateQuiz,
              child: const Text('Generate Quiz'),
            ),
            ElevatedButton(
              onPressed: _resetScore,
              child: const Text('Reset Score'),
            ),
            ElevatedButton(
              onPressed: _displayScore,
              child: const Text('Display Score'),
            ),
          ],
        ),
      ),
    );
  }
}
