import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'question.dart';
import 'question_factory.dart';

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
    final questions = await loadQuestions(questionFactory, questionCount);

    _questions.clear();
    for (var question in questions) {
      addQuestion(question);
    }
  }

  Future<List<Question>> loadQuestions(
      QuestionFactory questionFactory, int questionCount) async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final List<dynamic> data = jsonDecode(response);

    final random = Random();
    final selectedData = (data..shuffle(random)).take(questionCount).toList();

    final Set<String> categoriesNeeded =
        selectedData.map<String>((json) => json['category'] as String).toSet();
    final questionTypes = await _loadQuestionTypes(categoriesNeeded);

    return selectedData.map((json) {
      final category = json['category'];
      final colorValue = int.parse(questionTypes[category]!['color']);
      final color = Color(colorValue);
      final icon = questionTypes[category]!['icon'];

      final questionType = questionFactory.getQuestionType(
        category,
        color,
        icon,
      );

      return Question(
        questionText: json['questionText'],
        options: List<String>.from(json['options']),
        correctAnswerIndex: json['correctAnswerIndex'],
        questionType: questionType,
      );
    }).toList();
  }

  Future<Map<String, Map<String, dynamic>>> _loadQuestionTypes(
      Set<String> categoriesNeeded) async {
    final String response =
        await rootBundle.loadString('assets/question_types.json');
    final List<dynamic> data = jsonDecode(response);

    final Map<String, Map<String, dynamic>> questionTypes = {};

    for (var json in data) {
      if (categoriesNeeded.contains(json['category'])) {
        questionTypes[json['category']] = {
          'color': json['color'],
          'icon': json['icon']
        };
      }
    }

    return questionTypes;
  }
}
