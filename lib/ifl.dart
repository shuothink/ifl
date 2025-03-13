
import 'ifl_platform_interface.dart';

class Ifl {
  Future<String?> getPlatformVersion() {
    return IflPlatform.instance.getPlatformVersion();
  }
}
