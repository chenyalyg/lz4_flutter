
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'lz4_flutter_platform_interface.dart';

class Lz4Flutter {


  static Future<Uint8List?>  lz4_encode(Uint8List bytes) async   {
    return Lz4FlutterPlatform.instance.lz4_encode(bytes);
  }

  static Future<Uint8List?>  lz4_decode(Uint8List bytes,int dst_len) async   {
    return Lz4FlutterPlatform.instance.lz4_decode(bytes,dst_len);
  }

  Future<String?> getPlatformVersion() {
    return Lz4FlutterPlatform.instance.getPlatformVersion();
  }
}
