
import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_platform_interface.dart';
import 'package:datatrans_plugin_flutter/src/model/datatrans_base_response.dart';
import 'package:datatrans_plugin_flutter/src/model/payment_params.dart';
import 'package:datatrans_plugin_flutter/src/model/saved_payment_params.dart';

class DatatransPluginFlutter {
  void initialize(String merchantId, String password) async {
    DatatransPluginFlutterPlatform.instance.initialize(merchantId, password);
  }

  Future<DatatransResponse<void>?> saveCardPaymentInfo() async {
    return DatatransPluginFlutterPlatform.instance.saveCardPaymentInfo();
  }

  Future<DatatransResponse<SavedPaymentParams>?> payment({required PaymentParams params}) async {
    return DatatransPluginFlutterPlatform.instance.payment(params);
  }

  Future<DatatransResponse<SavedPaymentParams>?> fastPayment({required PaymentParams params, required SavedPaymentParams saveParams}) async {
    return DatatransPluginFlutterPlatform.instance.fastPayment(params, saveParams);
  }
}
