import 'package:datatrans_plugin_flutter/src/model/datatrans_define.dart';

class SavedPaymentInfo {
  final String alias;
  final PaymentMethodType paymentType;

  SavedPaymentInfo({
    required this.alias, 
    required this.paymentType
  });

  Map<String, Object?> get toJson {
    return <String, Object?>{
      'alias': alias,
      'paymentType': paymentType,
    }; 
  }
}
