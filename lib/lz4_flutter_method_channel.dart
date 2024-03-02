import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lz4_flutter_platform_interface.dart';

/// An implementation of [Lz4FlutterPlatform] that uses method channels.
class MethodChannelLz4Flutter extends Lz4FlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lz4_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Uint8List?> lz4_encode(Uint8List bytes)  async {
    final Uint8List? dst = await methodChannel.invokeMethod('lz4_encode',{"src":bytes});
    return dst;
  }

  @override
  Future<Uint8List?> lz4_decode(Uint8List bytes,int dst_len) async   {
    final Uint8List? dst = await methodChannel.invokeMethod('lz4_decode',{"src":bytes,"dst_len":dst_len});
    return dst;
  }
}
