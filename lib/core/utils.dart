import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:todaytest/data/qna.dart';
import 'package:dart_openai/dart_openai.dart';

class Utils {
  Utils._();
  static final Utils _instance = Utils._();
  factory Utils() => _instance;
  Map<String, dynamic> jsonData = {};
  Map<String, dynamic> embeddingData = {};

  Future<void> initialLoad() async {
    jsonData =
        jsonDecode(await rootBundle.loadString('assets/data/question.json'));
    embeddingData =
        jsonDecode(await rootBundle.loadString('assets/data/embedding.json'));
  }

  Future<List<double>> getEmbedding(String code, String data) async {
    List<double> embedding = (await OpenAI.instance.embedding.create(
      model: "text-embedding-ada-002",
      input: data,
    ))
        .data[0]
        .embeddings;
    embeddingData[code] = embedding;
    final file = File('assets/data/embedding.json');
    await file.writeAsString(jsonEncode(embeddingData));
    return embedding;
  }

  Future<Question> getQuestion(String code) async {
    Question question = Question.fromJson(jsonData[code]);
    question.embedding = List<double>.from(embeddingData[question.code] ??
        await getEmbedding(question.code, question.data));

    List<Option> options = question.answer;
    for (int index = 0; index < options.length; index++) {
      options[index].code = "A${question.code!.substring(1)}_$index";
    }
    await Future.forEach(options, (Option option) async {
      option.embedding = List<double>.from(embeddingData[option.code] ??
          await getEmbedding(option.code, option.data));
    });

    jsonData[code] = question.toJson();
    return question;
  }

  Map<String, Question> getAllQuestion() {
    Map<String, Question> result = {};

    jsonData.forEach((key, value) {
      result[key] = Question.fromJson(value);
    });
    return result;
  }
}
