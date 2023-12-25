// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInfo _$PaymentInfoFromJson(Map<String, dynamic> json) => PaymentInfo(
      currency: json['currency'] as String,
      amount: json['amount'] as int,
      autoSettle: json['autoSettle'] as bool? ?? false,
      saveAlias: json['saveAlias'] as bool? ?? false,
      paymentMethods: (json['paymentMethods'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PaymentInfoToJson(PaymentInfo instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'amount': instance.amount,
      'autoSettle': instance.autoSettle,
      'saveAlias': instance.saveAlias,
      'paymentMethods': instance.paymentMethods,
    };
