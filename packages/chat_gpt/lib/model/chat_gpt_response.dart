import 'package:chat_gpt/model/usage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'choices.dart';

part 'chat_gpt_response.g.dart';

/// Created by Collins Ihezie
/// January 26th 2023

@JsonSerializable()
class ChatGptResponse {
  String? id;
  String? object;
  num? created;
  String? model;
  List<Choices>? choices;
  Usage? usage;

  ChatGptResponse(
      {this.id,
      this.object,
      this.created,
      this.model,
      this.choices,
      this.usage});

  @override
  String toString() {
    return 'ChatGptResponse{id: $id, object: $object, created: $created, model: $model, choices: $choices, usage: $usage}';
  }

  factory ChatGptResponse.fromJson(Map<String, dynamic> json) => _$ChatGptResponseFromJson(json);
}