import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lz4_flutter_method_channel.dart';

abstract class Lz4FlutterPlatform extends PlatformInterface {
  /// Constructs a Lz4FlutterPlatform.
  Lz4FlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static Lz4FlutterPlatform _instance = MethodChannelLz4Flutter();

  /// The default instance of [Lz4FlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelLz4Flutter].
  static Lz4FlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Lz4FlutterPlatform] when
  /// they register themselves.
  static set instance(Lz4FlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Uint8List?> lz4_encode(Uint8List bytes)  {
    throw UnimplementedError('lz4_encode() has not been implemented.');
  }

  Future<Uint8List?> lz4_decode(Uint8List bytes,int dst_len)  {
    throw UnimplementedError('lz4_decode() has not been implemented.');
  }
}
