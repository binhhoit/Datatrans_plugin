// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_payment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedPaymentInfo _$SavedPaymentInfoFromJson(Map<String, dynamic> json) =>
    SavedPaymentInfo(
      alias: json['alias'] as String,
      cardNumber: json['cardNumber'] as String,
      cardHolder: json['cardHolder'] as String?,
      expiredDate: json['expiredDate'] == null
          ? null
          : CardExpiredDate.fromJson(
              json['expiredDate'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] as String,
    );

Map<String, dynamic> _$SavedPaymentInfoToJson(SavedPaymentInfo instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'cardNumber': instance.cardNumber,
      'cardHolder': instance.cardHolder,
      'expiredDate': instance.expiredDate?.toJson(),
      'paymentMethod': instance.paymentMethod,
    };
