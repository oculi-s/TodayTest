import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recommendation/core/answer.controller.dart';

import '../core/router.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    /// browser history back 버튼으로 인해
    /// intro screen으로 다시 돌아가게 될 경우 기존 응답 데이터 초기화
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AnswerController>().clearResult('0');
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: -120,
                right: 55,
                child: Image.asset(
                  'assets/doctor-hand.png',
                  height: MediaQuery.of(context).size.height * 400 / 800,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                  ),
                  Text(
                    'Find out which test\nyou need',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    'Which of the many tests\nin the hospital would be necessary?',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    '''Don't miss out on important conditions with TodayTest and get treated in time.''',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.5).copyWith(
          top: 33,
          bottom: 24,
        ),
        child: ElevatedButton(
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
            router.replace('/question/1');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Text(
              'Start AI Questionnaire',
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
