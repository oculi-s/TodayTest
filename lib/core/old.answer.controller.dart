import 'package:flutter/material.dart';
import 'package:todaytest/core/old.utils.dart';
import 'package:todaytest/data/old.question.dart';

class AnswerOXController with ChangeNotifier {
  /// 모든 답변 종류 : {index : 답변} 형식
  /// index : 실제 질문 순서
  final Map<String, Map<Question, bool>> _answer = {};
  final Map<String, List<String>> _checkUp = {
    // "1": [
    //   "Gastroscopy (위내시경)",
    //   "Colonoscopy (대장내시경)",
    //   "abdominal Ultrasound (복부 초음파)",
    //   "Diabetes Test (당뇨병 검사)",
    //   "Chest PA (흉부 엑스레이)",
    //   "Urinalysis (요분석)",
    //   "ECG (심전도)",
    //   "Echocardiogram (심초음파)",
    //   "Thyroid Function Test (갑상선 기능 검사)",
    // ],

    // "Colonoscopy (대장내시경)",
    // "abdominal Ultrasound (복부 초음파)",
    // "Diabetes Test (당뇨병 검사)",
    // "Chest PA (흉부 엑스레이)",
    // "Urinalysis (요분석)",
    // "ECG (심전도)",
    // "Echocardiogram (심초음파)",
    // "Thyroid Function Test (갑상선 기능 검사)",
  };
  final Map<String, String> _expression = {
    // "1": "체중감소",
    // "변비",
  };

  void setAnswer(String index, bool answer, Question question) {
    _answer[index] = {question: answer};

    if (answer) {
      _expression[index] = question.expression;
    } else {
      _expression.removeWhere((key, value) => key == index);
    }
  }

  void setCheckup() {
    Map<String, int> count = {};

    /// 질문 그룹별 yes 응답 갯 수 카운팅
    _answer.forEach((index, obj) {
      var parentNumber = obj.keys.first.current.split('-')[0];
      count.putIfAbsent(parentNumber, () => 0);

      var cnt = count[parentNumber]!;

      if (obj.values.first) {
        count[parentNumber] = ++cnt;
      }
    });

    // yes 응답이 하나라도 있다면 _checkUp에 해당 그룹의 추천 검사 추가
    count.forEach((parentNumber, count) {
      var index = Utils()
          .getAllQuestion()
          .entries
          .where((element) => element.value.current == parentNumber)
          .first
          .key;

      if (count > 0) {
        _checkUp[index] = Utils().getQuestion(index).checkUp;
      } else {
        _checkUp.remove(index);
      }
    });
  }

  String getIndex(String current) {
    var questions = Utils().getAllQuestion();

    return questions.entries
        .where((element) => element.value.current == current)
        .first
        .key;
  }

  bool? getAnswer(String number) {
    return _answer[number]?.values.first;
  }

  List<String> get checkUpList {
    List<String> list = [];

    for (var element in _checkUp.values) {
      list.addAll(element);
    }

    return list;
  }

  /// 대답 버튼 누르는 순간 이후 순서 질문에 대한 이전 답변 초기화 하고 시작
  void clearResult(String index) {
    var questions = Utils().getAllQuestion();
    var total = questions.length;

    for (int i = int.parse(index) + 1; i < total; i++) {
      var idx = i.toString();

      _answer.remove(idx);
      _checkUp.remove(idx);
      _expression.remove(idx);
    }
  }

  Map<String, String> get expressionList => _expression;
}
