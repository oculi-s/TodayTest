import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todaytest/core/answer.controller.dart';
import 'package:todaytest/component/custom_radio.dart';
import 'package:todaytest/data/question.dart';
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
    Key? key,
    required this.from,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var isDoc = from == 'doctor';
    var align = isDoc ? CrossAxisAlignment.start : CrossAxisAlignment.end;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: align,
            children: [
              SizedBox(
                width: 200,
                child: SvgPicture.asset(
                  'assets/question.svg',
                ),
              ),
              SizedBox(
                width: 200,
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
    );
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              }
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: const [
                Bubble(
                  from: 'doctor',
                  label: '어디가 아파서 오셨나요?',
                ),
                Bubble(
                  from: 'patient',
                  label: '가슴이 아파서 왔어요.',
                ),
              ],
            )),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16.5).copyWith(
      //     top: 33,
      //     bottom: 24,
      //   ),
      //   child: Column(children: [
      //     Container(
      //       margin: EdgeInsets.all(8),
      //       child: TextField(
      //         autofocus: true,
      //         controller: myController,
      //       ),
      //     ),
      //     ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(
      //             12,
      //           ),
      //           side: BorderSide.none,
      //         ),
      //         backgroundColor: Theme.of(context).primaryColor,
      //       ),
      //       onPressed: () async {
      //         router.replace('/question/1');
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(
      //           vertical: 15,
      //         ),
      //         child: Text(
      //           '전송',
      //           style: textTheme.bodyMedium?.copyWith(
      //             color: Colors.white,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ]),
      // ),
    );
  }
}
