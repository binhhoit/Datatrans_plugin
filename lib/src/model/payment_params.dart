import 'package:datatrans_plugin_flutter/datatrans_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_params.g.dart';

class PaymentParams {
  final PaymentInfo _paymentInfo;

  PaymentParams(
      {required String currency,
        required int amount,
        bool autoSettle = false,
        bool saveAlias = false,
        required List<PaymentMethodType> paymentMethods}) : 
        _paymentInfo = PaymentInfo(
          currency: currency,
          amount: amount,
          autoSettle: autoSettle,
          saveAlias: saveAlias,
          paymentMethods: paymentMethods.map((e) => e.rawValue).toList(),
         );

  factory PaymentParams.fromJson(Map<String, dynamic> json) {
    var paymentInfo = _$PaymentInfoFromJson(json);
    return PaymentParams(
      amount: paymentInfo.amount,
      currency: paymentInfo.currency,
      autoSettle: paymentInfo.autoSettle,
      saveAlias: paymentInfo.saveAlias,
      paymentMethods: paymentInfo.paymentMethods.map((e) => PaymentMethodTypeExtension.fromRawValue(e)).toList());
  }

  Map<String, dynamic> toJson() => _paymentInfo.toJson();
}

@JsonSerializable()
class PaymentInfo {
  final String currency;
  final int amount;
  final bool autoSettle;
  final bool saveAlias;
  final List<String> paymentMethods;

  PaymentInfo(
      {required this.currency,
      required this.amount,
      this.autoSettle = false,
      this.saveAlias = false,
      required this.paymentMethods});

  factory PaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoToJson(this);
}
