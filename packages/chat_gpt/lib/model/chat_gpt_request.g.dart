// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_gpt_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatGptRequest _$ChatGptRequestFromJson(Map<String, dynamic> json) =>
    ChatGptRequest(
      model: json['model'] as String?,
      prompt: json['prompt'] as String?,
      max_tokens: json['max_tokens'] as int?,
      temperature: json['temperature'] as int?,
      top_p: json['top_p'] as int?,
      n: json['n'] as int?,
      stream: json['stream'] as bool?,
      logprobs: json['logprobs'] as String?,
      stop: json['stop'] as String?,
    );

Map<String, dynamic> _$ChatGptRequestToJson(ChatGptRequest instance) =>
    <String, dynamic>{
      'model': instance.model,
      'prompt': instance.prompt,
      'max_tokens': instance.max_tokens,
      'temperature': instance.temperature,
      'top_p': instance.top_p,
      'n': instance.n,
      'stream': instance.stream,
      'logprobs': instance.logprobs,
      'stop': instance.stop,
    };
