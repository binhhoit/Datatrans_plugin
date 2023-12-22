import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datatrans_plugin_flutter/datatrans_plugin_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDatatransPluginFlutter platform = MethodChannelDatatransPluginFlutter();
  const MethodChannel channel = MethodChannel('datatrans_plugin_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
