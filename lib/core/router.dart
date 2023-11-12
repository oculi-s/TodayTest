import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todaytest/screen/intro.screen.dart';
import 'package:todaytest/screen/question.screen.dart';
import 'package:todaytest/screen/result.screen.dart';
import 'package:todaytest/screen/splash.screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/intro',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const IntroScreen(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
      builder: (BuildContext context, GoRouterState state) {
        return const IntroScreen();
      },
    ),
    GoRoute(
      path: '/question/:questionIndex',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: QuestionScreen(
            questionIndex: state.pathParameters['questionIndex'] ?? '1',
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: false,
            child: child,
          ),
        );
      },
    ),
    GoRoute(
      path: '/result',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const ResultScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: false,
            child: child,
          ),
        );
      },
    ),
  ],
);
