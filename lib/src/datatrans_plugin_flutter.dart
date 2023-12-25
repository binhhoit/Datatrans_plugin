
import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_platform_interface.dart';
import 'package:datatrans_plugin_flutter/src/model/payment_card_info.dart';
import 'package:datatrans_plugin_flutter/src/model/payment_params.dart';
import 'package:datatrans_plugin_flutter/src/model/saved_payment_params.dart';

class DatatransPluginFlutter {
  void initialize(String merchantId, String password) async {
    DatatransPluginFlutterPlatform.instance.initialize(merchantId, password);
  }

  Future<bool> saveCardPaymentInfo() async {
    return DatatransPluginFlutterPlatform.instance.saveCardPaymentInfo();
  }

  Future<List<PaymentCardInfo>?> getAllPaymentAlias() async {
    return DatatransPluginFlutterPlatform.instance.getAllPaymentAlias();
  }

  Future<bool> payment({required PaymentParams params}) async {
    return DatatransPluginFlutterPlatform.instance.payment(params);
  }

  Future<bool> fastPayment({required SavedPaymentParams params}) async {
    return DatatransPluginFlutterPlatform.instance.fastPayment(params);
  }
}
