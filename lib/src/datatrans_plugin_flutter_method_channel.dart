import 'dart:convert';
import 'dart:core';
import 'package:datatrans_plugin_flutter/src/model/datatrans_base_request.dart';
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
  void initialize(String merchantId, String password, bool isTesting, String appCallbackScheme) async {
    var methodName = DatatransMethodIdentity.initialize.methodName;
    var dict = {
      "merchantId": merchantId,
      "password": password,
      "isTesting": isTesting,
      "appCallbackScheme": appCallbackScheme
    };
    await methodChannel.invokeMethod<Map<String, dynamic>>(methodName, dict);
  }

  @override
  Future<DatatransResponse<SavedPaymentParams>?> payment(PaymentParams params) async {
    var methodName = DatatransMethodIdentity.payment.methodName;
    var request = DatatransRequest(
      payment: params.toJson()
    );
    try {
      final results = await methodChannel.invokeMethod<String>(methodName, request.toJson());
      if (results != null) {
        Map<String, dynamic> valueMap = json.decode(results);
        var response = DatatransResponse<SavedPaymentParams>.fromJson(
          valueMap,
          (e) => SavedPaymentParams.fromJson(e as Map<String, dynamic>));
        return response;
      }
      return DatatransResponse(error: "Payment not success", success: false, data: null);
    } catch (e) {
      return DatatransResponse(error: e.toString() , success: false, data: null);
    }
  }
  
  @override
  Future<DatatransResponse<SavedPaymentParams>?> fastPayment(PaymentParams params, SavedPaymentParams saveParams) async {
    var methodName = DatatransMethodIdentity.fastPayment.methodName;
    var request = DatatransRequest(
      payment: params.toJson(), 
      cards: saveParams.toJson()
    );
    try {
      final results = await methodChannel.invokeMethod<String>(methodName, request.toJson());
      if (results != null) {
        Map<String, dynamic> valueMap = json.decode(results);
        var response = DatatransResponse<SavedPaymentParams>.fromJson(
          valueMap,
          (e) => SavedPaymentParams.fromJson(e as Map<String, dynamic>));
        return response;
      }
      return DatatransResponse(error: "Payment not success", success: false, data: null);
    } catch (e) {
      return DatatransResponse(error: e.toString() , success: false, data: null);
    }
  }
}
