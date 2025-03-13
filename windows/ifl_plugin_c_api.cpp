#include "include/ifl/ifl_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "ifl_plugin.h"

void IflPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  ifl::IflPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
