
import 'package:json_annotation/json_annotation.dart';

part 'datatrans_base_request.g.dart';

@JsonSerializable()
class DatatransRequest<T> {
  final Map<String, dynamic> payment;
  final Map<String, dynamic>? cards;

  DatatransRequest({
    required this.payment,
    this.cards,
  });

  factory DatatransRequest.fromJson(
          Map<String, dynamic> json) =>
      _$DatatransRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DatatransRequestToJson(this);
}