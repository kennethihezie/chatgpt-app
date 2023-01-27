import 'package:chat_gpt_app/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'di/di.dart';


/// Created by Collins Ihezie
/// January 26th 2023


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DiContainer.setUpDi();

  Bloc.observer = ChatGptBlocObserver();


  runApp(MyApp());
}


