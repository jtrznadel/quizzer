import 'package:flutter/material.dart';
import 'package:quizzer/data/question/question.dart';
import 'package:quizzer/data/question/question_factory.dart';
import 'package:quizzer/data/question/question_type.dart';

class QuizManager {
  final List<Question> _questions = [];
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

  void generateQuiz(QuestionFactory questionTypeFactory) {
    final scienceQuestionType = questionTypeFactory.getQuestionType(
      'Science',
      Colors.green,
      'science_icon',
    );

    final mathQuestionType = questionTypeFactory.getQuestionType(
      'Math',
      Colors.red,
      'math_icon',
    );

    addQuestion(generateQuestion(
      'What is the chemical symbol for water?',
      ['H2O', 'O2', 'CO2', 'NaCl'],
      0,
      scienceQuestionType,
    ));

    addQuestion(generateQuestion(
      'What is 2 + 2?',
      ['3', '4', '5', '6'],
      1,
      mathQuestionType,
    ));

    addQuestion(generateQuestion(
      'What planet is known as the Red Planet?',
      ['Earth', 'Mars', 'Jupiter', 'Venus'],
      1,
      scienceQuestionType,
    ));
  }

  Question generateQuestion(String questionText, List<String> options,
      int answer, QuestionType questionType) {
    return Question(
      questionText: questionText,
      options: options,
      correctAnswerIndex: answer,
      questionType: questionType,
    );
  }

  void printQuestions() {
    for (var question in _questions) {
      print(
          'Question: ${question.questionText}, Category: ${question.questionType.getCategory()}, Color: ${question.questionType.getColor()}, Icon: ${question.questionType.getIcon()}');
    }
  }
}
