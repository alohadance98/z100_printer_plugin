import 'dart:ffi';
import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'z100_printer_plugin_method_channel.dart';

abstract class Z100PrinterPluginPlatform extends PlatformInterface {
  /// Constructs a Z100PrinterPluginPlatform.
  Z100PrinterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static Z100PrinterPluginPlatform _instance = MethodChannelZ100PrinterPlugin();

  /// The default instance of [Z100PrinterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelZ100PrinterPlugin].
  static Z100PrinterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Z100PrinterPluginPlatform] when
  /// they register themselves.
  static set instance(Z100PrinterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> initPrinter() {
    throw UnimplementedError('printText() has not been implemented.');
  }

  Future<Void?> printText(String text) {
    throw UnimplementedError('printText() has not been implemented.');
  }

  Future<Void?> printPicture(Uint8List pic) {
    throw UnimplementedError('printPic() has not been implemented.');
  }
}
