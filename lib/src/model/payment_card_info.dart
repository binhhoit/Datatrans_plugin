import 'package:datatrans_plugin_flutter/src/model/datatrans_define.dart';
import 'package:datatrans_plugin_flutter/src/model/saved_payment_params.dart';

import 'package:json_annotation/json_annotation.dart';

part 'payment_card_info.g.dart';

@JsonSerializable()
class PaymentCardInfo {
  final SavedPaymentParams savedPayment;
  final String transactionId;

  PaymentCardInfo({required this.savedPayment, required this.transactionId});

  factory PaymentCardInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCardInfoToJson(this);
}
