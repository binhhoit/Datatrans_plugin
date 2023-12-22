
import 'datatrans_plugin_flutter_platform_interface.dart';

class DatatransPluginFlutter {
  Future<String?> getPlatformVersion() {
    return DatatransPluginFlutterPlatform.instance.getPlatformVersion();
  }
}
