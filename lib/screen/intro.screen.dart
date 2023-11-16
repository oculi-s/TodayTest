import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todaytest/core/old.answer.controller.dart';

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
      context.read<AnswerOXController>().clearResult('0');
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
                    '내게 꼭 필요한 검사를\n알아보아요',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    '병원의 수많은 검사들 중 어떤 검사가\n필요할까요?',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    ''''오늘검사'와 함께 중요한 질환을\n놓치지 마시고 제때에 치료받으세요.''',
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
              borderRadius: BorderRadius.circular(12),
              side: BorderSide.none,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onPressed: () async {
            router.replace('/question/1');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'AI문진 시작하기',
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
