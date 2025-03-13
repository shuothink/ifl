import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ifl_platform_interface.dart';

/// An implementation of [IflPlatform] that uses method channels.
class MethodChannelIfl extends IflPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ifl');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
