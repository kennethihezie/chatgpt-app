part of 'chat_gpt_bloc.dart';

/// Created by Collins Ihezie
/// January 26th 2023


abstract class ChatGptObserverEvent extends Equatable {
  const ChatGptObserverEvent();

  @override
  List<Object?> get props => [];
}

class ChatGptRegisterSubscription extends ChatGptObserverEvent {
  final ChatGptRequest chatGptRequest;
  const ChatGptRegisterSubscription(this.chatGptRequest);

  @override
  List<Object?> get props => [chatGptRequest];
}

class ChatGptInitial extends ChatGptObserverEvent {
  const ChatGptInitial();
}



