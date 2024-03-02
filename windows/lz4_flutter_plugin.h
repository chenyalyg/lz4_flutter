#ifndef FLUTTER_PLUGIN_LZ4_FLUTTER_PLUGIN_H_
#define FLUTTER_PLUGIN_LZ4_FLUTTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>


namespace lz4_flutter {

class Lz4FlutterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  Lz4FlutterPlugin();

  virtual ~Lz4FlutterPlugin();

  // Disallow copy and assign.
  Lz4FlutterPlugin(const Lz4FlutterPlugin&) = delete;
  Lz4FlutterPlugin& operator=(const Lz4FlutterPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace lz4_flutter

#endif  // FLUTTER_PLUGIN_LZ4_FLUTTER_PLUGIN_H_
