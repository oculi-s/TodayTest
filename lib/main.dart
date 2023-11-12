import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recommendation/core/answer.controller.dart';
import 'package:recommendation/core/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnswerController(),
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'NotoSansKR',
          primaryColor: const Color(
            0xff2E3840,
          ),
          highlightColor: const Color(
            0xff6E757D,
          ),
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child ?? Container(),
          );
        },
      ),
    );
  }
}
