part of 'chat_gpt_bloc.dart';

/// Created by Collins Ihezie
/// January 26th 2023


enum ChatGptObserverStatus{ initial, loading, success, failure }

extension ChatGptObserverStatusX on ChatGptObserverStatus {
  bool get initial => this == ChatGptObserverStatus.initial;
  bool get isLoading => this == ChatGptObserverStatus.loading;
  bool get isSuccess => this == ChatGptObserverStatus.success;
  bool get isFailure => this == ChatGptObserverStatus.failure;
}


class ChatGptObserverState extends Equatable {
  final ChatGptObserverStatus status;
  final ChatGptResponse? chatGptResponse;

  const ChatGptObserverState({this.status = ChatGptObserverStatus.initial, this.chatGptResponse});

  ChatGptObserverState copyWith({ChatGptObserverStatus? status, ChatGptResponse? chatGptResponse}) {
    return ChatGptObserverState(status: status ?? this.status, chatGptResponse: chatGptResponse);
  }

  @override
  List<Object?> get props => [status, chatGptResponse];
}
