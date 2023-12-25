import 'dart:core';
import 'package:datatrans_plugin_flutter/src/model/datatrans_base_response.dart';
import 'package:datatrans_plugin_flutter/src/model/saved_payment_params.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:datatrans_plugin_flutter/src/datatrans_define.dart';
import 'package:datatrans_plugin_flutter/src/model/payment_params.dart';
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
    var results = await methodChannel.invokeMethod<Map<String, dynamic>>(methodName, dict);

    if (results != null) {
      var response = DatatransResponse<void>.fromJson(
        results,
        (e) => ());
      print("initialize ${response.error}");
    }
  }

  @override
  Future<DatatransResponse<void>?> saveCardPaymentInfo() async {
    var methodName = DatatransMethodIdentity.saveCardPaymentInfo.methodName;
    try {
      final results = await methodChannel.invokeMethod<Map<String, dynamic>>(methodName);
      if (results != null) {
        var response = DatatransResponse<void>.fromJson(
          results,
          (e) => ());
        return response;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DatatransResponse<SavedPaymentParams>?> payment(PaymentParams params) async {
    var methodName = DatatransMethodIdentity.payment.methodName;
    var dict = params.toJson();
    try {
      final results = await methodChannel.invokeMethod<Map<String, dynamic>>(methodName, dict);
      if (results != null) {
        var response = DatatransResponse<SavedPaymentParams>.fromJson(
          results,
          (e) => SavedPaymentParams.fromJson(e as Map<String, dynamic>));
        return response;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<DatatransResponse<SavedPaymentParams>?> fastPayment(PaymentParams params, SavedPaymentParams saveParams) async {
    var methodName = DatatransMethodIdentity.fastPayment.methodName;
    var dict = {
      "payment" : params.toJson(), 
      "cards": saveParams.toJson()
    };
    try {
      final results = await methodChannel.invokeMethod<Map<String, dynamic>>(methodName, dict);
      if (results != null) {
        var response = DatatransResponse<SavedPaymentParams>.fromJson(
          results,
          (e) => SavedPaymentParams.fromJson(e as Map<String, dynamic>));
        return response;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
