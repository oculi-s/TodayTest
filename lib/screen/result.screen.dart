import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:recommendation/core/answer.controller.dart';
import 'package:screenshot/screenshot.dart';

import "../core/save_mobile.dart" if (dart.library.html) "../core/save_web.dart"
    as func;

part '../data/result.json.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    AnswerController controller = context.read<AnswerController>();

    return Scaffold(
      body: Stack(
        children: [
          if (controller.checkUpList.isEmpty)
            Positioned(
              right: 50,
              bottom: -100,
              child: Image.asset(
                'assets/doctor.png',
                height: MediaQuery.of(context).size.height * 450 / 800,
              ),
            ),
          SafeArea(
            child: Screenshot(
              controller: screenshotController,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: ListView(
                  children: List.generate(
                    controller.checkUpList.length + 1,
                    (index) {
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 45,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                controller.checkUpList.isNotEmpty
                                    ? 'Test Recommendation Results'
                                    : "'오늘검사' 추천 결과입니다",
                                style: textTheme.headlineSmall?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: controller.checkUpList.isNotEmpty
                                      ? 24
                                      : 22,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            controller.checkUpList.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: ui.Color.fromARGB(
                                                255, 239, 242, 243),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/lightball.svg'),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    'Please check!',
                                                    style: textTheme.titleSmall
                                                        ?.copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Each test is recommended considering the patient's symptoms and history, but the most important thing is the doctor's judgment. Multiple tests can be performed together if necessary for accurate diagnosis.",
                                                style: textTheme.titleMedium
                                                    ?.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24),
                                        child: Container(
                                          height: 8,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'My symptom',
                                              style: textTheme.titleLarge
                                                  ?.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                controller
                                                    .expressionList.length,
                                                (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        controller
                                                            .expressionList
                                                            .entries
                                                            .elementAt(index)
                                                            .value,
                                                        style: textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        String.fromCharCode(
                                                            Icons
                                                                .circle_outlined
                                                                .codePoint),
                                                        style: TextStyle(
                                                          inherit: false,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          fontFamily: Icons
                                                              .circle_outlined
                                                              .fontFamily,
                                                          color: Theme.of(
                                                                  context)
                                                              .highlightColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 32),
                                        child: Container(
                                          height: 8,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 32,
                                        ),
                                        child: Text(
                                          'Recommended tests',
                                          style: textTheme.titleLarge?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          r''''오늘검사'가 환자분의 증상을 바탕으로 
추천하는 검사는 현재 없습니다.''',
                                          style:
                                              textTheme.titleMedium?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Text(
                                          r'''그러나 반드시 의사 선생님과 
상의하신 후 나에게 필요한 검사를 받아주세요.''',
                                          style:
                                              textTheme.titleMedium?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        );
                      }

                      String checkUp =
                          controller.checkUpList.elementAt(index - 1);

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/${checkupInfo[checkUp]?['icon']}',
                                  width: 32,
                                  height: 32,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  checkupInfo[checkUp]?['name'] ?? '',
                                  style: textTheme.titleLarge?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            Text(
                              checkupInfo[checkUp]?['contents'] ?? '',
                              style: textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).highlightColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            index != controller.checkUpList.length
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 44,
                                    ),
                                    child: Divider(
                                      thickness: 1.5,
                                      color: Colors.grey[300],
                                    ),
                                  )
                                : const SizedBox(
                                    height: 44,
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(bottom: kIsWeb ? 20 : 0),
          child: controller.checkUpList.isNotEmpty
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      side: BorderSide.none,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    final bytes =
                        await screenshotController.captureFromLongWidget(
                      InheritedTheme.captureAll(
                        context,
                        Material(
                          child: longWidget(controller),
                        ),
                      ),
                      delay: const Duration(milliseconds: 100),
                      context: context,
                    );

                    func.saveImageFile(bytes, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Text(
                      'Save result',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : Container(
                  height: 53,
                ),
        ),
      ),
    );
  }
}

Widget longWidget(AnswerController controller) {
  return Builder(builder: (context) {
    return Container(
      width: 390,
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),

      ///
      /// Note: Do not use Scrolling widget, instead place your children in Column.
      ///
      /// Do not use widgets like 'Expanded','Flexible',or 'Spacer'
      ///
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(controller.checkUpList.length + 1, (index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '검사 추천 결과',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: const BoxDecoration(
                          color: ui.Color.fromARGB(255, 239, 242, 243),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/lightball.svg'),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '확인해 주세요!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '각 검사는 환자의 증상과 과거력 등을 고려하여 추천되지만, 가장 중요한 것은 의사 선생님의 판단입니다. 정확한 진단을 위해 필요한 경우 여러 검사를 함께 실시할 수 있습니다.',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Container(
                        height: 8,
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '나의 증상',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              controller.expressionList.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      controller.expressionList.entries
                                          .elementAt(index)
                                          .value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      String.fromCharCode(
                                          Icons.circle_outlined.codePoint),
                                      style: TextStyle(
                                        inherit: false,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                        fontFamily:
                                            Icons.circle_outlined.fontFamily,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Container(
                        height: 8,
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 32,
                      ),
                      child: Text(
                        '추천 검사',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          var checkUp = controller.checkUpList.elementAt(index - 1);

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/${checkupInfo[checkUp]?['icon']}',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      checkupInfo[checkUp]?['name'] ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                Text(
                  checkupInfo[checkUp]?['contents'] ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).highlightColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                index != controller.checkUpList.length
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 44,
                        ),
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[300],
                        ),
                      )
                    : const SizedBox(
                        height: 44,
                      ),
              ],
            ),
          );
        }),
      ),
    );
  });
}
