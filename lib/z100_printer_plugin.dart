import 'dart:ffi';
import 'dart:typed_data';

import 'z100_printer_plugin_platform_interface.dart';

class Z100PrinterPlugin {
  Future<Void?> initPrinter() {
    return Z100PrinterPluginPlatform.instance.initPrinter();
  }

  Future<Void?> printText(String text) {
    return Z100PrinterPluginPlatform.instance.printText(text);
  }

  Future<Void?> printPicture(Uint8List picture) {
    return Z100PrinterPluginPlatform.instance.printPicture(picture);
  }
}
