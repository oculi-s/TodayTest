/// ## 1. Question의 구조
/// * data : 질문텍스트
/// * type : 0=OX, 1=객관식, 2=주관식
/// * code : 질문코드
class Question {
  String data = '';
  String type = '';
  String code = '';
  List<double> embedding = [];
  List<Option> answer = [];

  Question();

  Question.fromJson(Map<String, dynamic> json) {
    data = json['data'].toString();
    type = json['type'].toString();
    code = json['code'].toString();
    answer = (json['answer'] as List<dynamic>)
        .map((e) => Option.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'type': type,
      'code': code,
      'answer': answer?.map((e) => e.toJson()).toList(),
    };
  }
}

class Option {
  String code = '';
  String data = '';
  String next = '';
  List<double> embedding = [];
  Option();

  Option.fromJson(Map<String, dynamic> json) {
    data = json['data'].toString();
    next = json['next'].toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'next': next,
    };
  }
}

/// Answer의 구조
/// code : 답변한 질문코드
/// data : 표준답변
/// next : 다음 질문 코드
/// embedding : embedding vector
class Answer {
  String code = '';
  String data = '';
  String next = '';
  List<double> embedding = [];
  Map<String, double> similarity = {};

  Answer({
    required this.data,
    required this.code,
  });

  Answer.fromJson(Map<String, dynamic> json) {
    data = json['data'].toString();
    next = json['next'].toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'data': data,
      'next': next,
    };
  }
}
