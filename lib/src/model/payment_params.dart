import 'package:json_annotation/json_annotation.dart';

part 'payment_params.g.dart';

@JsonSerializable()
class PaymentParams {
  final String currency;
  final int amount;
  final bool autoSettle;
  final bool saveAlias;
  final List<String> paymentMethods;

  PaymentParams(
      {required this.currency,
      required this.amount,
      this.autoSettle = false,
      this.saveAlias = false,
      required this.paymentMethods});

  factory PaymentParams.fromJson(Map<String, dynamic> json) => _$PaymentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentParamsToJson(this);
}
