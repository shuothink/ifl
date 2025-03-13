import 'package:flutter_test/flutter_test.dart';
import 'package:ifl/ifl.dart';
import 'package:ifl/ifl_platform_interface.dart';
import 'package:ifl/ifl_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIflPlatform
    with MockPlatformInterfaceMixin
    implements IflPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IflPlatform initialPlatform = IflPlatform.instance;

  test('$MethodChannelIfl is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIfl>());
  });

  test('getPlatformVersion', () async {
    Ifl iflPlugin = Ifl();
    MockIflPlatform fakePlatform = MockIflPlatform();
    IflPlatform.instance = fakePlatform;

    expect(await iflPlugin.getPlatformVersion(), '42');
  });
}
