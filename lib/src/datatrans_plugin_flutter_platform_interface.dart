import 'package:datatrans_plugin_flutter/src/model/payment_card_info.dart';
import 'package:datatrans_plugin_flutter/src/model/payment_params.dart';
import 'package:datatrans_plugin_flutter/src/model/saved_payment_params.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'datatrans_plugin_flutter_method_channel.dart';

abstract class DatatransPluginFlutterPlatform extends PlatformInterface {
  DatatransPluginFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static DatatransPluginFlutterPlatform _instance =
      MethodChannelDatatransPluginFlutter();
  static DatatransPluginFlutterPlatform get instance => _instance;

  static set instance(DatatransPluginFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void initialize(String merchantId, String password);
  Future<bool> saveCardPaymentInfo();
  Future<List<PaymentCardInfo>?> getAllPaymentAlias();
  Future<bool> payment(PaymentParams params);
  Future<bool> fastPayment(SavedPaymentParams params);
}
