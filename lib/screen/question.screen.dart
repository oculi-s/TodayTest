import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todaytest/component/custom_radio.dart';
import 'package:todaytest/core/answer.controller.dart';
import 'package:todaytest/data/qna.dart';
import 'package:todaytest/core/router.dart';
import 'package:todaytest/core/utils.dart';

class QuestionScreen extends StatefulWidget {
  final String questionIndex;

  const QuestionScreen({
    super.key,
    required this.questionIndex,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class Bubble extends StatelessWidget {
  final String from, label;

  const Bubble({
    super.key,
    required this.from,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    bool isDoc = from == 'doctor';
    Alignment align = isDoc ? Alignment(-1, 0) : Alignment(1, 0);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        alignment: align,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.primaryColorLight,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: <Widget>[
                isDoc
                    ? SizedBox(
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/question.svg',
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  child: Text(
                    label,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  final textController = TextEditingController();
  final scrollController = ScrollController();
  final answerController = AnswerController();
  bool cansubmit = true;
  List<Bubble> bubbles = [];
  Question? question;
  Future<void> addQuestion({String? code}) async {
    print("Q $cansubmit");
    if (code == null) return;
    question = await Utils().getQuestion(code);
    setState(() {
      bubbles.add(
        Bubble(
          from: 'doctor',
          label: question!.data,
        ),
      );
    });
    await Future.delayed(Duration(milliseconds: 500));
    textController.clear();
  }

  Future<void> addAnswer({String? input}) async {
    print("A $cansubmit");
    if (input == null && textController.text == '') return;
    if (!cansubmit || question == null) return;
    String data = input ?? textController.text;
    setState(() {
      bubbles.add(
        Bubble(
          from: 'patient',
          label: data,
        ),
      );
    });

    cansubmit = false;
    Answer answer = Answer(data: data, code: question!.code);

    /// question.type에 따라 다르게 생각해야
    await answerController.addAnswerData(answer);
    await Future.delayed(Duration(milliseconds: 500));
    textController.clear();
    if (Utils().jsonData[answer.next] == null) {
    } else {
      await addQuestion(code: answer.next);
    }
    cansubmit = true;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await addQuestion(code: 'A0');
    await addAnswer(input: '가슴');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (router.canPop()) {
                router.pop();
              } else {
                router.replace('/intro');
              }
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        // child: SizedBox.shrink(),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.secondaryHeaderColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            child: ListView.builder(
              controller: scrollController,
              itemCount: bubbles.length,
              itemBuilder: (context, index) {
                return bubbles[index];
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.5, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: textController,
                onEditingComplete: addAnswer,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide.none,
                ),
                backgroundColor: theme.primaryColor,
              ),
              onPressed: addAnswer,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Icon(Icons.send_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
