import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage_client.dart';

/// Adapts [FlutterSecureStorage] to [SecureStorageClient].
class FlutterSecureStorageClientAdapter implements SecureStorageClient {
  FlutterSecureStorageClientAdapter(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() {
    return _storage.deleteAll();
  }

  @override
  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  @override
  Future<Map<String, String>> readAll() {
    return _storage.readAll();
  }

  @override
  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }
}
