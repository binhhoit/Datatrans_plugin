import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_define.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'datatrans_plugin_flutter_platform_interface.dart';

class MethodChannelDatatransPluginFlutter extends DatatransPluginFlutterPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('datatrans_plugin_flutter');

  @override
  Future<String?> initializeTransaction() async {
    var methodName = DatatransMethodIdentity.initializeTransaction.methodName;
    final version = await methodChannel.invokeMethod<String>(methodName);
    return version;
  }
}
