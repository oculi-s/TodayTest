import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todaytest/core/router.dart';
import 'package:todaytest/core/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Utils().readQuestionJson();

      Timer(const Duration(milliseconds: 2500), () {
        router.replace('/intro');
        // router.replace('/result');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 36,
          ),
          child: Stack(
            children: [
              Positioned(
                right: MediaQuery.of(context).size.width * 10 / 360,
                bottom: MediaQuery.of(context).size.height * 80 / 800,
                child: Image.asset(
                  'assets/stethoscope.png',
                  height: MediaQuery.of(context).size.height * 220 / 800,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    '중요한 검사를',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    '늦기 전에 받으세요',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Image.asset(
          'assets/logo.png',
          width: 95,
          height: 95,
        ),
      ),
    );
  }
}
