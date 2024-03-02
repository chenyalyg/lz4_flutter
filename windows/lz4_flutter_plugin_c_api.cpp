#include "include/lz4_flutter/lz4_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "lz4_flutter_plugin.h"

void Lz4FlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  lz4_flutter::Lz4FlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
