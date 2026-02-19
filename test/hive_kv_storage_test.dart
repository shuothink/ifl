import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:ifl/ifl_hive.dart';
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

class _FakeHive implements HiveInterface {
  _FakeHive(this._box);

  final Box<String> _box;
  String? openedBoxName;

  @override
  Future<Box<E>> openBox<E>(
    String name, {
    HiveCipher? encryptionCipher,
    KeyComparator? keyComparator,
    CompactionStrategy? compactionStrategy,
    bool? crashRecovery,
    String? path,
    Uint8List? bytes,
    String? collection,
    List<int>? encryptionKey,
  }) async {
    openedBoxName = name;
    return _box as Box<E>;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

class _FakeBox implements Box<String> {
  _FakeBox(this.name);

  final Map<String, String> _values = <String, String>{};

  @override
  final String name;

  @override
  Iterable<dynamic> get keys => _values.keys;

  @override
  Future<int> clear() async {
    final length = _values.length;
    _values.clear();
    return length;
  }

  @override
  Future<void> close() async {}

  @override
  bool containsKey(dynamic key) => _values.containsKey(key);

  @override
  Future<void> delete(dynamic key) async {
    _values.remove(key);
  }

  @override
  String? get(dynamic key, {String? defaultValue}) {
    return _values[key] ?? defaultValue;
  }

  @override
  Future<void> put(dynamic key, String value) async {
    _values[key as String] = value;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
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

  test('initHiveKvStorage should use default boxName', () async {
    final fakeBox = _FakeBox('@ifl');
    final fakeHive = _FakeHive(fakeBox);

    final storage = await initHiveKvStorage(hive: fakeHive);

    expect(fakeHive.openedBoxName, '@ifl');
    expect(storage.name, '@ifl');
  });

  test('initHiveKvStorage should open box and return writable storage',
      () async {
    final fakeBox = _FakeBox('auto_box');
    final fakeHive = _FakeHive(fakeBox);

    final storage = await initHiveKvStorage(
      boxName: 'auto_box',
      hive: fakeHive,
    );

    expect(fakeHive.openedBoxName, 'auto_box');
    expect(storage.name, 'auto_box');

    await storage.write('k', 'v');
    expect(await storage.read('k'), 'v');
  });
}
