import 'package:chat_gpt_app/app/routes.dart';
import 'package:chat_gpt_app/di/di.dart';
import 'package:chat_gpt_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/chat_gpt_bloc.dart';

/// Created by Collins Ihezie
/// January 26th 2023

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: ChatGptRoutes.home,
      builder: (context, state) => BlocProvider(create: (context) => ChatGptBloc(DiContainer.getIt.get()), child: const HomePage(),),
    ),
  ]);


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      title: 'ChatGpt',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue),
    );
  }
}
