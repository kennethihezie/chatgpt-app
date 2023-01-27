// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_gpt_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatGptResponse _$ChatGptResponseFromJson(Map<String, dynamic> json) =>
    ChatGptResponse(
      id: json['id'] as String?,
      object: json['object'] as String?,
      created: json['created'] as num?,
      model: json['model'] as String?,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => Choices.fromJson(e as Map<String, dynamic>))
          .toList(),
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatGptResponseToJson(ChatGptResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
      'usage': instance.usage,
    };
