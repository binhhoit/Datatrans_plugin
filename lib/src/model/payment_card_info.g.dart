// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentCardInfo _$PaymentCardInfoFromJson(Map<String, dynamic> json) =>
    PaymentCardInfo(
      savedPayment: SavedPaymentParams.fromJson(
          json['savedPayment'] as Map<String, dynamic>),
      transactionId: json['transactionId'] as String,
    );

Map<String, dynamic> _$PaymentCardInfoToJson(PaymentCardInfo instance) =>
    <String, dynamic>{
      'savedPayment': instance.savedPayment,
      'transactionId': instance.transactionId,
    };
