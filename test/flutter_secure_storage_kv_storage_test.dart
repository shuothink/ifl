import 'package:flutter_test/flutter_test.dart';
import 'package:ifl/src/storage/impl/secure/flutter_secure_storage_kv_storage.dart';
import 'package:ifl/src/storage/impl/secure/secure_storage_client.dart';

class _FakeSecureStorageClient implements SecureStorageClient {
  final Map<String, String> _store = <String, String>{};

  @override
  Future<void> delete(String key) async {
    _store.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    _store.clear();
  }

  @override
  Future<String?> read(String key) async {
    return _store[key];
  }

  @override
  Future<Map<String, String>> readAll() async {
    return Map<String, String>.from(_store);
  }

  @override
  Future<void> write(String key, String value) async {
    _store[key] = value;
  }
}

void main() {
  test('FlutterSecureStorageKvStorage should namespace keys', () async {
    final client = _FakeSecureStorageClient();
    final storageA =
        FlutterSecureStorageKvStorage(name: 'secureA', client: client);
    final storageB =
        FlutterSecureStorageKvStorage(name: 'secureB', client: client);

    await storageA.write('token', 'a');
    await storageB.write('token', 'b');

    expect(await storageA.read('token'), 'a');
    expect(await storageB.read('token'), 'b');
    expect(await storageA.keys(), <String>['token']);
    expect(await storageB.keys(), <String>['token']);
  });

  test('FlutterSecureStorageKvStorage clear should only clear same namespace',
      () async {
    final client = _FakeSecureStorageClient();
    final storageA =
        FlutterSecureStorageKvStorage(name: 'secureA', client: client);
    final storageB =
        FlutterSecureStorageKvStorage(name: 'secureB', client: client);

    await storageA.write('token', 'a');
    await storageB.write('token', 'b');

    await storageA.clear();

    expect(await storageA.read('token'), isNull);
    expect(await storageB.read('token'), 'b');
  });
}
