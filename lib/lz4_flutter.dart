
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class Lz4Flutter {
  static const MethodChannel _channel = MethodChannel('lz4_flutter');


  static Future<Uint8List?>  lz4_encode(Uint8List bytes) async   {
    final Uint8List? dst = await _channel.invokeMethod('lz4_encode',{"src":bytes});
    return dst;
  }

  static Future<Uint8List?>  lz4_decode(Uint8List bytes,int dst_len) async   {
    final Uint8List? dst = await _channel.invokeMethod('lz4_decode',{"src":bytes,"dst_len":dst_len});
    return dst;
  }
}
