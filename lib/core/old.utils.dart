import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:todaytest/data/old.question.dart';

class Utils {
  Utils._();

  static final Utils _instance = Utils._();

  factory Utils() => _instance;

  Map<String, dynamic> jsonData = {};

  Future<void> readQuestionJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    jsonData = jsonDecode(response);
  }

  Question getQuestion(String key) {
    Question question = Question.fromJson(jsonData[key]);

    return question;
  }

  Map<String, Question> getAllQuestion() {
    Map<String, Question> result = {};

    jsonData.forEach((key, value) {
      result[key] = Question.fromJson(value);
    });
    return result;
  }

  bool isEndOfQuestion(Question question) {
    return question.next.isEmpty;
  }
}
