
import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_platform_interface.dart';

class DatatransPluginFlutter {
  void initialize(String merchantId, String password) async {
    DatatransPluginFlutterPlatform.instance.initialize(merchantId, password);
  }

  Future<bool?> saveCardPaymentInfo() async {
    return DatatransPluginFlutterPlatform.instance.saveCardPaymentInfo();
  }

  Future<bool?> payment({required int amount}) async {
    return DatatransPluginFlutterPlatform.instance.payment(amount);
  }
}
