import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'datatrans_plugin_flutter_platform_interface.dart';

/// An implementation of [DatatransPluginFlutterPlatform] that uses method channels.
class MethodChannelDatatransPluginFlutter extends DatatransPluginFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('datatrans_plugin_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
