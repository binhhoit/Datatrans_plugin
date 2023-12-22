import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'datatrans_plugin_flutter_method_channel.dart';

abstract class DatatransPluginFlutterPlatform extends PlatformInterface {
  /// Constructs a DatatransPluginFlutterPlatform.
  DatatransPluginFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static DatatransPluginFlutterPlatform _instance = MethodChannelDatatransPluginFlutter();

  /// The default instance of [DatatransPluginFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelDatatransPluginFlutter].
  static DatatransPluginFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DatatransPluginFlutterPlatform] when
  /// they register themselves.
  static set instance(DatatransPluginFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
