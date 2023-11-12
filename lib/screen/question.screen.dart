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

class _QuestionScreenState extends State<QuestionScreen> {
  Question? question;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        question = Utils().getQuestion(widget.questionIndex);

        setState(() {});
      } catch (e) {
        router.go('/');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final answerController = context.read<AnswerController>();
    bool? prevAnswer = answerController.getAnswer(widget.questionIndex);
    var textTheme = Theme.of(context).textTheme;

    return question == null
        ? const SizedBox.shrink()
        : Scaffold(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: SvgPicture.asset(
                            'assets/question.svg',
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            question!.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomRadioComponent(
                      onSelect: () {
                        /// 예 시나리오
                        /// 1. clearResult - 현재 응답된 질문 이후 순서 질문의 기존 응답을 전부 삭제
                        /// 2. setAnswer - {index : bool} 형태로 답변 저장(true), {index: String} 형태로 질문에 해당하는 표현 문구 저장
                        /// 3. setCheckup - 다음 질문 혹은 결과 화면으로 넘어갈때 호출, 질문 그룹별 Yes 응답이 하나라도 있을 경우 해당 그룹의 추천 검사 저장
                        /// 4. 화면 이동
                        answerController.clearResult(widget.questionIndex);

                        String next = question!.next;

                        answerController.setAnswer(
                          widget.questionIndex,
                          true,
                          question!,
                        );

                        answerController.setCheckup();
                        if (next.isEmpty) {
                          router.push('/result');
                        } else {
                          router.push(
                              '/question/${answerController.getIndex(next)}');
                        }
                      },
                      title: '예',
                      isSelected: prevAnswer ?? false,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomRadioComponent(
                      onSelect: () {
                        /// 아니오 시나리오
                        /// 1. clearResult - 현재 응답된 질문 이후 순서 질문의 기존 응답을 전부 삭제
                        /// 2. setAnswer - {index : bool} 형태로 답변 저장(false), 현재 index의 표현 문구 삭제
                        /// 3. setCheckup - 다음 질문 혹은 결과 화면으로 넘어갈때 호출, 질문 그룹별 Yes 응답이 하나라도 있을 경우 해당 그룹의 추천 검사 저장
                        /// 4. 화면 이동
                        answerController.clearResult(widget.questionIndex);

                        String sub = question!.subQuestion;
                        String next = question!.next;

                        answerController.setAnswer(
                          widget.questionIndex,
                          false,
                          question!,
                        );

                        if (sub.isEmpty && next.isEmpty) {
                          answerController.setCheckup();
                          router.push('/result');
                        } else if (sub.isEmpty && question!.next.isNotEmpty) {
                          answerController.setCheckup();
                          router.push(
                              '/question/${answerController.getIndex(next)}');
                        } else {
                          router.push(
                              '/question/${answerController.getIndex(sub)}');
                        }
                      },
                      title: '아니오',
                      isSelected: prevAnswer == null ? false : !prevAnswer,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
