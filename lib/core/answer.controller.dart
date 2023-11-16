import 'package:flutter/material.dart';
import 'package:todaytest/core/utils.dart';
import 'package:todaytest/data/qna.dart';
import 'package:dart_openai/dart_openai.dart';

import 'dart:convert';
import 'dart:math';
import 'dart:io';

double simil(List<double> a, List<double> b) {
  double dotProduct = 0;
  for (int i = 0; i < min(a.length, b.length); i++) {
    dotProduct += a[i] * b[i];
  }
  double normA =
      sqrt(a.map((e) => e * e).reduce((sum, element) => sum + element));
  double normB =
      sqrt(b.map((e) => e * e).reduce((sum, element) => sum + element));
  double similarity = dotProduct / (normA * normB);
  return similarity;
}

class AnswerController {
  late final _answer = <Answer>[];
  final jsonData = Utils().jsonData;
  final embeddingData = Utils().embeddingData;

  Future<void> addAnswerData(Answer answer) async {
    List<double> embedding = (await OpenAI.instance.embedding.create(
      model: "text-embedding-ada-002",
      input: answer.data,
    ))
        .data[0]
        .embeddings;

    Question question = await Utils().getQuestion(answer.code);
    answer.similarity = Map.fromEntries(
      question.answer.map(
        (e) => MapEntry(
          e.next,
          simil(embedding, List<double>.from(embeddingData[e.code])),
        ),
      ),
    );

    answer.next = answer.similarity.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    _answer.add(answer);
  }

  void saveResult() async {
    var now = DateTime.now().millisecondsSinceEpoch;
    final file = File("assets/$now.json");
    await file.writeAsString(jsonEncode(_answer));
  }
}
