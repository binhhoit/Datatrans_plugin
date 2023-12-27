// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datatrans_base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatatransRequest<T> _$DatatransRequestFromJson<T>(Map<String, dynamic> json) =>
    DatatransRequest<T>(
      payment: json['payment'] as Map<String, dynamic>,
      cards: json['cards'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DatatransRequestToJson<T>(
        DatatransRequest<T> instance) =>
    <String, dynamic>{
      'payment': instance.payment,
      'cards': instance.cards,
    };
