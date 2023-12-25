// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_payment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedPaymentInfo _$SavedPaymentInfoFromJson(Map<String, dynamic> json) =>
    SavedPaymentInfo(
      alias: json['alias'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );

Map<String, dynamic> _$SavedPaymentInfoToJson(SavedPaymentInfo instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'paymentMethod': instance.paymentMethod,
    };
