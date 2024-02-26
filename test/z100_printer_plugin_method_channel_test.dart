import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:z100_printer_plugin/z100_printer_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelZ100PrinterPlugin platform = MethodChannelZ100PrinterPlugin();
  const MethodChannel channel = MethodChannel('z100_printer_plugin');

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
