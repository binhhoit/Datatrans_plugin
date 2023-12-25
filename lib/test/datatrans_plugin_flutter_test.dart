import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_method_channel.dart';
import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datatrans_plugin_flutter/datatrans_plugin_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDatatransPluginFlutterPlatform
    with MockPlatformInterfaceMixin
    implements DatatransPluginFlutterPlatform {

  @override
  Future<String?> initializeTransaction() => Future.value('42');
}

void main() {
  final DatatransPluginFlutterPlatform initialPlatform = DatatransPluginFlutterPlatform.instance;

  test('$MethodChannelDatatransPluginFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDatatransPluginFlutter>());
  });

  test('initializeTransaction', () async {
    DatatransPluginFlutter datatransPluginFlutterPlugin = DatatransPluginFlutter();
    MockDatatransPluginFlutterPlatform fakePlatform = MockDatatransPluginFlutterPlatform();
    DatatransPluginFlutterPlatform.instance = fakePlatform;

    expect(await datatransPluginFlutterPlugin.initializeTransaction(), '42');
  });
}
