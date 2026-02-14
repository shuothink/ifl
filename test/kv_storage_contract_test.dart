import 'package:flutter_test/flutter_test.dart';
import 'package:ifl/ifl.dart';

class _InMemoryKvStorage implements KvStorage {
  _InMemoryKvStorage(this.name);

  final Map<String, String> _store = <String, String>{};

  @override
  final String name;

  @override
  Future<void> clear() async {
    _store.clear();
  }

  @override
  Future<void> close() async {}

  @override
  Future<bool> containsKey(String key) async {
    return _store.containsKey(key);
  }

  @override
  Future<void> delete(String key) async {
    _store.remove(key);
  }

  @override
  Future<List<String>> keys() async {
    return _store.keys.toList()..sort();
  }

  @override
  Future<String?> read(String key) async {
    return _store[key];
  }

  @override
  Future<void> write(String key, String value) async {
    _store[key] = value;
  }
}

void main() {
  group('KvStorage contract', () {
    late KvStorage storage;

    setUp(() {
      storage = _InMemoryKvStorage('test_kv');
    });

    test('write/read/containsKey', () async {
      await storage.write('token', 'abc');

      expect(await storage.containsKey('token'), isTrue);
      expect(await storage.read('token'), 'abc');
    });

    test('delete removes existing key', () async {
      await storage.write('token', 'abc');
      await storage.delete('token');

      expect(await storage.read('token'), isNull);
      expect(await storage.containsKey('token'), isFalse);
    });

    test('clear removes all keys', () async {
      await storage.write('a', '1');
      await storage.write('b', '2');
      await storage.clear();

      expect(await storage.keys(), isEmpty);
    });
  });
}
