import 'package:flutter/services.dart';

class BluetoothChannel {
  static const MethodChannel _channel =
      const MethodChannel('bluetooth_channel');

  static Future<void> enableBluetooth() async {
    try {
      print('coming to enable bluttoth');
      await _channel.invokeMethod('enableBluetooth');
    } on PlatformException catch (e) {
      print('Failed to enable Bluetooth: ${e.message}');
    }
  }
}
