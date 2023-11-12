class Question {
  final String title;
  final String next;
  final String subQuestion;
  final List<String> checkUp;
  final String expression;
  final String current;

  Question({
    required this.title,
    required this.next,
    required this.subQuestion,
    required this.checkUp,
    required this.expression,
    required this.current,
  });

  Question.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        next = json['next'],
        subQuestion = json['subQuestion'],
        checkUp = (json['checkUp'] as List).map((e) => e as String).toList(),
        expression = json['expression'],
        current = json['current'];
}
