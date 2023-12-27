// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datatrans_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatatransResponse<T> _$DatatransResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    DatatransResponse<T>(
      error: json['error'] as String?,
      success: json['success'] as bool? ?? true,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      bodyError: json['bodyError'],
    );

Map<String, dynamic> _$DatatransResponseToJson<T>(
  DatatransResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'error': instance.error,
      'success': instance.success,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'bodyError': instance.bodyError,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
