import 'package:flutter_test/flutter_test.dart';
import 'package:z100_printer_plugin/z100_printer_plugin.dart';
import 'package:z100_printer_plugin/z100_printer_plugin_platform_interface.dart';
import 'package:z100_printer_plugin/z100_printer_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZ100PrinterPluginPlatform
    with MockPlatformInterfaceMixin
    implements Z100PrinterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final Z100PrinterPluginPlatform initialPlatform = Z100PrinterPluginPlatform.instance;

  test('$MethodChannelZ100PrinterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZ100PrinterPlugin>());
  });

  test('getPlatformVersion', () async {
    Z100PrinterPlugin z100PrinterPlugin = Z100PrinterPlugin();
    MockZ100PrinterPluginPlatform fakePlatform = MockZ100PrinterPluginPlatform();
    Z100PrinterPluginPlatform.instance = fakePlatform;

    expect(await z100PrinterPlugin.getPlatformVersion(), '42');
  });
}
