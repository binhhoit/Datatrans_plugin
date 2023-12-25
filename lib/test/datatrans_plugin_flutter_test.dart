import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_method_channel.dart';
import 'package:datatrans_plugin_flutter/src/datatrans_plugin_flutter_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

// class MockDatatransPluginFlutterPlatform
//     with MockPlatformInterfaceMixin
//     implements DatatransPluginFlutterPlatform {

//   @override
//   Future<String?> initializeTransaction() => Future.value('42');
// }

void main() {
  final DatatransPluginFlutterPlatform initialPlatform = DatatransPluginFlutterPlatform.instance;

  test('$MethodChannelDatatransPluginFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDatatransPluginFlutter>());
  });

  // test('initializeTransaction', () async {
  //   DatatransPluginFlutter _datatransFlutterPlugin = DatatransPluginFlutter();
  //   MockDatatransPluginFlutterPlatform fakePlatform = MockDatatransPluginFlutterPlatform();
  //   DatatransPluginFlutterPlatform.instance = fakePlatform;

  //   expect(await _datatransFlutterPlugin.initializeTransaction(), '42');
  // });
}
