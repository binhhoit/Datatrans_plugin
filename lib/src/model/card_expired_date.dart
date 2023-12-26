import 'package:json_annotation/json_annotation.dart';

part 'card_expired_date.g.dart';

@JsonSerializable()
class CardExpiredDate {
  final int month;
  final int year;

  CardExpiredDate({required this.month, required this.year});

  factory CardExpiredDate.fromJson(Map<String, dynamic> json) =>
      _$CardExpiredDateFromJson(json);

  Map<String, dynamic> toJson() => _$CardExpiredDateToJson(this);
}