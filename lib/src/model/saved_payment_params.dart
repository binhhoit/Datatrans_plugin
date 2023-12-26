import 'package:datatrans_plugin_flutter/datatrans_flutter.dart';
import 'package:datatrans_plugin_flutter/src/model/card_expired_date.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saved_payment_params.g.dart';

class SavedPaymentParams {
  final SavedPaymentInfo _paymentInfo;

  SavedPaymentParams(
      { required String alias,
        required String cardNumber,
        String? cardHolder,
        CardExpiredDate? expiredDate,
        required PaymentMethodType paymentMethod}) : 
        _paymentInfo = SavedPaymentInfo(
          alias: alias,
          cardNumber: cardNumber,
          cardHolder: cardHolder,
          expiredDate: expiredDate,
          paymentMethod: paymentMethod.rawValue,
         );

  factory SavedPaymentParams.fromJson(Map<String, dynamic> json) {
    var savedPayment = SavedPaymentInfo.fromJson(json);
    return SavedPaymentParams(
      alias: savedPayment.alias,
      cardNumber: savedPayment.cardNumber,
      cardHolder: savedPayment.cardHolder,
      expiredDate: savedPayment.expiredDate,
      paymentMethod: PaymentMethodTypeExtension.fromRawValue(savedPayment.paymentMethod));
  }

  Map<String, dynamic> toJson() => _paymentInfo.toJson();

  String get alias => _paymentInfo.alias;
  String get cardNumber => _paymentInfo.cardNumber;
  String? get cardHolder => _paymentInfo.cardHolder;
  CardExpiredDate? get expiredDate => _paymentInfo.expiredDate;
  PaymentMethodType get paymentMethod => PaymentMethodTypeExtension.fromRawValue(_paymentInfo.paymentMethod);
}

@JsonSerializable()
class SavedPaymentInfo {
  final String alias;
  final String cardNumber;
  final String? cardHolder;
  final CardExpiredDate? expiredDate;
  final String paymentMethod;

  SavedPaymentInfo({
    required this.alias, 
    required this.cardNumber,
    this.cardHolder,
    this.expiredDate,
    required this.paymentMethod
  });

  factory SavedPaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$SavedPaymentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SavedPaymentInfoToJson(this);
}
