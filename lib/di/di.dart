import 'package:chat_gpt/network/network_service.dart';
import 'package:chat_gpt/repository/repository.dart';
import 'package:get_it/get_it.dart';

/// Created by Collins Ihezie
/// January 26th 2023


class DiContainer{
  static final getIt = GetIt.instance;

  static setUpDi() {
    getIt.registerLazySingleton<ChatGptNetworkService>(
            () => ChatGptNetworkService());

    getIt.registerLazySingleton<ChatGptRepository>(() =>
        ChatGptRepository(
            getIt.get<ChatGptNetworkService>()));
  }
}