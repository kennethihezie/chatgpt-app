import 'package:json_annotation/json_annotation.dart';

part 'choices.g.dart';

/// Created by Collins Ihezie
/// January 26th 2023

@JsonSerializable()
class Choices{
  String? text;
  num? index;
  dynamic logprobs;
  String? finish_reason;


  Choices({this.text, this.index, this.logprobs, this.finish_reason});


  @override
  String toString() {
    return 'Choices{text: $text, index: $index, logprobs: $logprobs, finish_reason: $finish_reason}';
  }

  factory Choices.fromJson(Map<String, dynamic> json) => _$ChoicesFromJson(json);
}