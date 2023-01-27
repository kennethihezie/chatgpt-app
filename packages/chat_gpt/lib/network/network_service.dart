import 'dart:convert';

import 'package:chat_gpt/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../model/chat_gpt_request.dart';
import '../model/chat_gpt_response.dart';

/// Created by Collins Ihezie
/// January 26th 2023

class ChatGptNetworkService {
  final _httpClient = http.Client();

  Future<ChatGptResponse?> sendChat(ChatGptRequest chatGptRequest) async {
    try{
      final request = Uri.https(Constants.baseUrl, '/v1/completions');
      final response = await _httpClient.post(request,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer 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"
          },
          body: jsonEncode(chatGptRequest.toMap()));


      print(response.body);

      final responseJson = jsonDecode(response.body);

      return ChatGptResponse.fromJson(responseJson);
    } on Exception catch(e){
      print(e.toString());
      return null;
    }
  }

  /*
  curl https://api.openai.com/v1/completions \
-H "Content-Type: application/json" \
-H "Authorization: Bearer YOUR_API_KEY" \
-d '{"model": "text-davinci-003", "prompt": "Say this is a test", "temperature": 0, "max_tokens": 7}'
   */
}
