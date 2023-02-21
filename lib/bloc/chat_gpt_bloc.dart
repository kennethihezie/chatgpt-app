import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_gpt/model/chat_gpt_request.dart';
import 'package:chat_gpt/model/chat_gpt_response.dart';
import 'package:chat_gpt/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_gpt_event.dart';
part 'chat_gpt_state.dart';

/// Created by Collins Ihezie
/// January 26th 2023

class ChatGptBloc extends Bloc<ChatGptObserverEvent, ChatGptObserverState> {
  final ChatGptRepository chatGptRepository;
  ChatGptBloc(this.chatGptRepository) : super(const ChatGptObserverState()) {
    on<ChatGptRegisterSubscription>((event, emit) => sendChat(event, emit));

    on<ChatGptInitial>((event, emit) => changeState(event, emit));
  }


  Future<void> sendChat(ChatGptRegisterSubscription event, Emitter<ChatGptObserverState> emitter) async {
    emitter(state.copyWith(status: ChatGptObserverStatus.loading));

    try {
      final chat = await chatGptRepository.sendChat(event.chatGptRequest);

      await emitter.forEach<ChatGptResponse?>(chat, onData: (data)  {
        if(data?.choices != null){
          return state.copyWith(status: ChatGptObserverStatus.success, chatGptResponse: data);
        } else {
          return state.copyWith(status: ChatGptObserverStatus.failure);
        }
      }, onError: (_, __) => state.copyWith(status: ChatGptObserverStatus.failure));
    } on Exception {
      emitter(state.copyWith(status: ChatGptObserverStatus.failure));
    }
  }


  Future<void> changeState(ChatGptInitial event, Emitter<ChatGptObserverState> emitter) async {
    emitter(state.copyWith(status: ChatGptObserverStatus.initial));
  }
}
