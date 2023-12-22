import 'package:flutter_test/flutter_test.dart';
import 'package:datatrans_plugin_flutter/datatrans_plugin_flutter.dart';
import 'package:datatrans_plugin_flutter/datatrans_plugin_flutter_platform_interface.dart';
import 'package:datatrans_plugin_flutter/datatrans_plugin_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDatatransPluginFlutterPlatform
    with MockPlatformInterfaceMixin
    implements DatatransPluginFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DatatransPluginFlutterPlatform initialPlatform = DatatransPluginFlutterPlatform.instance;

  test('$MethodChannelDatatransPluginFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDatatransPluginFlutter>());
  });

  test('getPlatformVersion', () async {
    DatatransPluginFlutter datatransPluginFlutterPlugin = DatatransPluginFlutter();
    MockDatatransPluginFlutterPlatform fakePlatform = MockDatatransPluginFlutterPlatform();
    DatatransPluginFlutterPlatform.instance = fakePlatform;

    expect(await datatransPluginFlutterPlugin.getPlatformVersion(), '42');
  });
}
