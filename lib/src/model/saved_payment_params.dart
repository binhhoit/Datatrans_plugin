import 'package:datatrans_plugin_flutter/datatrans_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saved_payment_params.g.dart';

class SavedPaymentParams {
  final SavedPaymentInfo _paymentInfo;

  SavedPaymentParams(
      {required String alias,
       required PaymentMethodType paymentMethod}) : 
        _paymentInfo = SavedPaymentInfo(
          alias: alias,
          paymentMethod: paymentMethod.rawValue,
         );

  factory SavedPaymentParams.fromJson(Map<String, dynamic> json) {
    var savedPayment = SavedPaymentInfo.fromJson(json);
    return SavedPaymentParams(
      alias: savedPayment.alias,
      paymentMethod: PaymentMethodTypeExtension.fromRawValue(savedPayment.paymentMethod));
  }

  Map<String, dynamic> toJson() => _paymentInfo.toJson();
}

@JsonSerializable()
class SavedPaymentInfo {
  final String alias;
  final String paymentMethod;

  SavedPaymentInfo({
    required this.alias, 
    required this.paymentMethod
  });

  factory SavedPaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$SavedPaymentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SavedPaymentInfoToJson(this);
}
