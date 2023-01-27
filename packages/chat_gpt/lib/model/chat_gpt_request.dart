import 'package:json_annotation/json_annotation.dart';
part 'chat_gpt_request.g.dart';

/// Created by Collins Ihezie
/// January 26th 2023

@JsonSerializable()
class ChatGptRequest{
  String? model = "text-davinci-003";
  String? prompt;
  int? max_tokens = 7;
  num? temperature = 0;
  int? top_p = 1;
  int? n = 1;
  bool? stream = false;
  String? logprobs = null;
  String? stop = "\n";

  ChatGptRequest(
      {this.model,
      this.prompt,
      this.max_tokens,
      this.temperature,
      this.top_p,
      this.n,
      this.stream,
      this.logprobs,
      this.stop});

  @override
  String toString() {
    return 'ChatGptRequest{model: $model, prompt: $prompt, max_tokens: $max_tokens, temperature: $temperature, top_p: $top_p, n: $n, stream: $stream, logprobs: $logprobs, stop: $stop}';
  }

  factory ChatGptRequest.fromJson(Map<String, dynamic> json) => _$ChatGptRequestFromJson(json);

  Map<String, dynamic> toMap(){
    return {
      'model':model,
      'prompt':prompt,
      'max_tokens':max_tokens,
      'temperature':temperature,
      'top_p':top_p,
      'n':n,
      'stream':stream,
      'logprobs':logprobs,
      'stop':stop
    };
  }
}