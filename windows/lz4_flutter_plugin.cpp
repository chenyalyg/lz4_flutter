#include "lz4_flutter_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <lz4.h>

namespace lz4_flutter
{

  // static
  void Lz4FlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "lz4_flutter",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<Lz4FlutterPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  Lz4FlutterPlugin::Lz4FlutterPlugin() {}

  Lz4FlutterPlugin::~Lz4FlutterPlugin() {}

  void Lz4FlutterPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("getPlatformVersion") == 0)
    {
      std::ostringstream version_stream;
      version_stream << "Windows ";
      if (IsWindows10OrGreater())
      {
        version_stream << "10+";
      }
      else if (IsWindows8OrGreater())
      {
        version_stream << "8";
      }
      else if (IsWindows7OrGreater())
      {
        version_stream << "7";
      }
      result->Success(flutter::EncodableValue(version_stream.str()));
    }
    else if (method_call.method_name().compare("lz4_encode") == 0)
    {
      const auto& arguments = *method_call.arguments();
      const auto& mapArgs = std::get<flutter::EncodableMap>(arguments);

      const flutter::EncodableValue& srcValue = mapArgs.at(flutter::EncodableValue("src"));
      const std::vector<uint8_t> src = std::get<std::vector<uint8_t>>(srcValue);

      std::vector<uint8_t> compressedData(LZ4_COMPRESSBOUND(src.size()));
      int compressedSize = LZ4_compress_default(reinterpret_cast<const char*>(src.data()), reinterpret_cast<char*>(compressedData.data()), (int)src.size(), (int)compressedData.size());
      if (compressedSize <= 0)
      {
        result->Success(flutter::EncodableValue(std::vector<uint8_t>()));
      }
      compressedData.resize(compressedSize);

      result->Success(flutter::EncodableValue(compressedData));
    }
    else if (method_call.method_name().compare("lz4_decode") == 0)
    {
      
      const auto& arguments = *method_call.arguments();
      const auto& mapArgs = std::get<flutter::EncodableMap>(arguments);

      const flutter::EncodableValue& srcValue = mapArgs.at(flutter::EncodableValue("src"));
      const std::vector<uint8_t> src = std::get<std::vector<uint8_t>>(srcValue);

      const flutter::EncodableValue& dstLenValue = mapArgs.at(flutter::EncodableValue("dst_len"));
      const int dst_len = std::get<int>(dstLenValue);

      std::vector<uint8_t> decompressedData(dst_len);
      
      int decompressedSize = LZ4_decompress_safe(reinterpret_cast<const char*>(src.data()), reinterpret_cast<char*>(decompressedData.data()), (int)src.size(), dst_len);

      if (decompressedSize < 0)
      {
        result->Success(flutter::EncodableValue(std::vector<uint8_t>()));
      }

      result->Success(flutter::EncodableValue(decompressedData));
    }
    else
    {
      result->NotImplemented();
    }
  }

} // namespace lz4_flutter
