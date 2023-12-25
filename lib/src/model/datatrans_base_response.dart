import 'package:json_annotation/json_annotation.dart';

part 'datatrans_base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DatatransResponse<T> {
  final String? error;
  final bool success;
  final T? data;

  DatatransResponse({
    this.error,
    this.success = true,
    this.data,
  });

  factory DatatransResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$DatatransResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$DatatransResponseToJson(this, toJsonT);
}