
import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_platform_interface.dart';

class DatatransPluginFlutter {
  Future<String?> getPlatformVersion() {
    return DatatransPluginFlutterPlatform.instance.initializeTransaction();
  }
}
