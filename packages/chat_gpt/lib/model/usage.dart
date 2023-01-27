import 'package:json_annotation/json_annotation.dart';

part 'usage.g.dart';

/// Created by Collins Ihezie
/// January 26th 2023


@JsonSerializable()
class Usage{
  num? prompt_tokens;
  num? completion_tokens;
  num? total_tokens;

  Usage({this.prompt_tokens, this.completion_tokens, this.total_tokens});

  @override
  String toString() {
    return 'Usage{prompt_tokens: $prompt_tokens, completion_tokens: $completion_tokens, total_tokens: $total_tokens}';
  }

  factory Usage.fromJson(Map<String, dynamic> json) => _$UsageFromJson(json);
}