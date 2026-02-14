import 'package:flutter_test/flutter_test.dart';
import 'package:ifl/src/storage/impl/hive/hive_box_contract.dart';
import 'package:ifl/src/storage/impl/hive/hive_kv_storage.dart';

class _FakeHiveBox implements HiveBoxContract {
  _FakeHiveBox(this.name);

  final Map<String, String> _map = <String, String>{};

  @override
  final String name;

  @override
  Future<void> clear() async {
    _map.clear();
  }

  @override
  Future<void> close() async {}

  @override
  bool containsKey(String key) => _map.containsKey(key);

  @override
  Future<void> delete(String key) async {
    _map.remove(key);
  }

  @override
  String? get(String key) => _map[key];

  @override
  Iterable<String> get keys => _map.keys;

  @override
  Future<void> put(String key, String value) async {
    _map[key] = value;
  }
}

void main() {
  test('HiveKvStorage should proxy box behavior', () async {
    final storage = HiveKvStorage(_FakeHiveBox('hive_box'));

    await storage.write('token', 'abc');

    expect(storage.name, 'hive_box');
    expect(await storage.containsKey('token'), isTrue);
    expect(await storage.read('token'), 'abc');

    await storage.delete('token');
    expect(await storage.read('token'), isNull);
  });

  test('HiveKvStorage clear should remove all keys', () async {
    final storage = HiveKvStorage(_FakeHiveBox('hive_box'));
    await storage.write('a', '1');
    await storage.write('b', '2');

    await storage.clear();

    expect(await storage.keys(), isEmpty);
  });
}
