import 'package:rxdart/rxdart.dart';
import '../model/chat_gpt_request.dart';
import '../model/chat_gpt_response.dart';
import '../network/network_service.dart';

/// Created by Collins Ihezie
/// January 26th 2023

class ChatGptRepository{
  final ChatGptNetworkService chatGptNetworkService;
  ChatGptRepository(this.chatGptNetworkService);
  final _chatGptStream = BehaviorSubject<ChatGptResponse?>.seeded(null);

  Future<Stream<ChatGptResponse?>> sendChat(ChatGptRequest chatGptRequest) async {
     final chat = await chatGptNetworkService.sendChat(chatGptRequest);
     if(chat != null){
       _chatGptStream.add(chat);
     }
     return _chatGptStream.asBroadcastStream();
  }
}