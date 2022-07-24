package com.chenya.lz4_flutter

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import net.jpountz.lz4.LZ4Factory

/** Lz4FlutterPlugin */
class Lz4FlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "lz4_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "lz4_encode") {
      var src= call.argument<ByteArray>("src")
      var dst=LZ4Factory.fastestInstance().fastCompressor().compress(src);
      result.success(dst)
    }else if (call.method == "lz4_decode") {
      var src= call.argument<ByteArray>("src")
      var dst_len=call.argument<Int>("dst_len")
      if (dst_len != null) {
        var dst=LZ4Factory.fastestInstance().fastDecompressor().decompress(src,dst_len)
        result.success(dst)
      }else{
        result.success(ByteArray(0))
      }

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
