import 'dart:core';

import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_define.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'datatrans_plugin_flutter_platform_interface.dart';

class MethodChannelDatatransPluginFlutter extends DatatransPluginFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('datatrans_plugin_flutter');

  @override
  void initialize(String merchantId, String password) async {
    var methodName = DatatransMethodIdentity.initialize.methodName;
    var dict = {
      "merchantId" : merchantId, 
      "password": password
    };
    await methodChannel.invokeMethod(methodName, dict);
  }

  @override
  Future<bool?> saveCardPaymentInfo() async {
    var methodName = DatatransMethodIdentity.saveCardPaymentInfo.methodName;
    final success = await methodChannel.invokeMethod<bool>(methodName);
    return success;
  }

  @override
  Future<bool?> payment(int amount) async {
    var methodName = DatatransMethodIdentity.payment.methodName;
    var dict = {
      "amount" : amount
    };
    final success = await methodChannel.invokeMethod<bool>(methodName, dict);
    return success;
  }
}
