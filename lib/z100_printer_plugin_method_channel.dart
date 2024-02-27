import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'z100_printer_plugin_platform_interface.dart';

/// An implementation of [Z100PrinterPluginPlatform] that uses method channels.
class MethodChannelZ100PrinterPlugin extends Z100PrinterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('z100_printer_plugin');

  @override
  Future<String?> initPrinter() async {
    String? value = await methodChannel.invokeMethod<String>('initSdk');
    return value;
  }

  @override
  Future<Void?> printText(String text) async {
    await methodChannel.invokeMethod<String>('printText', {"text": text});
  }

  @override
  Future<Void?> printPicture(Uint8List pic) async {
    await methodChannel.invokeMethod<String>('printPicture', {"picture": pic});
  }
}
